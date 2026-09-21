\# DevAiCoreX CLI — Theme System



This document defines the CLI theme system. Themes control color output for human-friendly CLI interaction.



\---



\# 1. Purpose of Themes



Themes provide:



\- readable output

\- color-coded messages

\- consistent formatting

\- improved user experience



\---



\# 2. Theme Elements



Themes define colors for:



header

success

warning

error

info

command



\---



\# 3. Default Theme



header: Cyan

success: Green

warning: Yellow

error: Red

info: Gray

command: Magenta



\---



\# 4. Theme Behavior



Themes apply to:



\- status output

\- build output

\- error output

\- routing output

\- help output



Themes do NOT affect:



\--json output



\---



\# 5. Theme Customization



Themes can be changed dynamically.



Example:



Set-DevAiTheme header Blue



\---



\# 6. Summary



devai-cli-themes.md defines the theme system for human-friendly CLI output.



