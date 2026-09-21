# DevAiCoreX Schema Lineage & Conversion Pipeline  
### YAML‑C → YAML → JSON → JSONC → JSON → CBOR

---

## 1. YAML‑C — Human‑Editable Source of Truth  
YAML‑C is the authoritative developer-facing schema format. It contains:

- human-readable structure  
- comments  
- metadata  
- lineage markers  
- inheritance hints  
- developer annotations  

YAML‑C cannot be encoded directly into CBOR.  
It must be normalized first.

---

## 2. YAML — Clean, Normalized YAML  
YAML‑C is normalized into pure YAML by:

- removing comments  
- resolving anchors  
- resolving tags  
- validating indentation  
- removing YAML-specific constructs CBOR cannot encode  

This produces a clean YAML representation.

---

## 3. JSON — Pure Machine‑Normalized Structure  
YAML is converted into pure JSON.

JSON provides:

- deterministic structure  
- strict typing  
- no comments  
- no YAML artifacts  

This is the first format CBOR can understand.

---

## 4. JSONC — Developer‑Friendly JSON  
JSON is expanded into JSONC by adding:

- comments  
- guardrail hints  
- lineage metadata  
- inheritance notes  

JSONC is used by:

- developers  
- guardrails  
- schema inspectors  
- lineage validators  

JSONC is not valid JSON for CBOR.

---

## 5. JSON (stripped) — CBOR‑Ready JSON  
JSONC is stripped of:

- comments  
- trailing commas  
- non-schema metadata  

This produces pure JSON suitable for CBOR encoding.

---

## 6. CBOR — Final Machine‑Binary Schema  
CBOR is the authoritative machine format.

It provides:

- compact binary encoding  
- fast parsing  
- deterministic structure  
- easy hashing  
- easy signing  
- strict validation  

CBOR is written to:

<module>.cbor

---

# Full Pipeline Summary

YAML‑C (human editable)
    ↓ strip comments + normalize
YAML (clean)
    ↓ convert
JSON (pure)
    ↓ add comments + metadata
JSONC (developer friendly)
    ↓ strip comments
JSON (pure again)
    ↓ encode
CBOR (machine binary)

---

# Logic Path Diagram

┌──────────────────────────────┐
│          YAML‑C              │
│  (human editable, annotated) │
└───────────────┬──────────────┘
                │ strip comments + normalize
┌───────────────▼──────────────┐
│            YAML               │
│   (clean, normalized YAML)    │
└───────────────┬──────────────┘
                │ convert
┌───────────────▼──────────────┐
│            JSON               │
│   (pure machine structure)    │
└───────────────┬──────────────┘
                │ add comments + metadata
┌───────────────▼──────────────┐
│            JSONC              │
│ (developer-friendly JSON+C)   │
└───────────────┬──────────────┘
                │ strip comments
┌───────────────▼──────────────┐
│            JSON               │
│   (pure JSON for CBOR)        │
└───────────────┬──────────────┘
                │ encode
┌───────────────▼──────────────┐
│            CBOR               │
│   (final machine binary)      │
└──────────────────────────────┘

