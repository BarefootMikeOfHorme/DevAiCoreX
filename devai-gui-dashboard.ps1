Add-Type -AssemblyName PresentationFramework

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

# Simple WPF XAML UI
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="DevAiCoreX Dashboard" Height="600" Width="900"
        WindowStartupLocation="CenterScreen" Background="#1E1E1E">
    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="40"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="120"/>
        </Grid.RowDefinitions>

        <TextBlock Grid.Row="0" Text="DevAiCoreX Dashboard"
                   Foreground="White" FontSize="20"
                   HorizontalAlignment="Left" VerticalAlignment="Center"/>

        <Grid Grid.Row="1">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <GroupBox Grid.Column="0" Header="Summary" Margin="5" Foreground="White">
                <TextBox Name="SummaryBox" Background="#252526" Foreground="White"
                         FontFamily="Consolas" FontSize="12"
                         IsReadOnly="True" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto"/>
            </GroupBox>

            <GroupBox Grid.Column="1" Header="Modules" Margin="5" Foreground="White">
                <ListView Name="ModuleList" Background="#252526" Foreground="White">
                    <ListView.View>
                        <GridView>
                            <GridViewColumn Header="Name" DisplayMemberBinding="{Binding Name}" Width="220"/>
                            <GridViewColumn Header="Size" DisplayMemberBinding="{Binding Size}" Width="80"/>
                            <GridViewColumn Header="Status" DisplayMemberBinding="{Binding Status}" Width="100"/>
                        </GridView>
                    </ListView.View>
                </ListView>
            </GroupBox>
        </Grid>

        <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Left" Margin="5">
            <Button Name="RefreshButton" Content="Refresh" Width="100" Margin="5"/>
            <Button Name="OpenSuperReportButton" Content="Open Super Report" Width="150" Margin="5"/>
            <Button Name="RunFinalizeButton" Content="Run Finalize" Width="120" Margin="5"/>
        </StackPanel>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$SummaryBox = $window.FindName("SummaryBox")
$ModuleList = $window.FindName("ModuleList")
$RefreshButton = $window.FindName("RefreshButton")
$OpenSuperReportButton = $window.FindName("OpenSuperReportButton")
$RunFinalizeButton = $window.FindName("RunFinalizeButton")

function Load-DashboardData {
    $summary = @()
    $summary += "DevAiCoreX Dashboard"
    $summary += "Root: $root"
    $summary += "Generated: $(Get-Date)"
    $summary += ""

    $modules = Get-ChildItem -Path $root -Filter "*.ps1" | Sort-Object Name
    $ModuleList.Items.Clear()

    foreach ($m in $modules) {
        $status = "OK"
        if ($m.Length -eq 0) { $status = "EMPTY" }

        $obj = New-Object PSObject -Property @{
            Name   = $m.Name
            Size   = $m.Length
            Status = $status
        }
        $ModuleList.Items.Add($obj) | Out-Null
    }

    $summary += "Total modules: $($modules.Count)"
    $empty = $modules | Where-Object { $_.Length -eq 0 }
    $summary += "Empty modules: $($empty.Count)"

    $SummaryBox.Text = ($summary -join "`r`n")
}

$RefreshButton.Add_Click({
    Load-DashboardData
})

$OpenSuperReportButton.Add_Click({
    $superTxt = Join-Path $root "super-report.txt"
    if (Test-Path $superTxt) {
        Start-Process $superTxt
    } else {
        [System.Windows.MessageBox]::Show("super-report.txt not found. Run finalize first.","DevAiCoreX")
    }
})

$RunFinalizeButton.Add_Click({
    $finalize = Join-Path $root "devai-finalize.ps1"
    if (Test-Path $finalize) {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$finalize`""
    } else {
        [System.Windows.MessageBox]::Show("devai-finalize.ps1 not found.","DevAiCoreX")
    }
})

Load-DashboardData

$window.ShowDialog() | Out-Null
