---
name: Field Ops Native
colors:
  surface: '#fff8f2'
  surface-dim: '#e0d9d2'
  surface-bright: '#fff8f2'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#faf2eb'
  surface-container: '#f4ede6'
  surface-container-high: '#eee7e0'
  surface-container-highest: '#e8e1db'
  on-surface: '#1e1b17'
  on-surface-variant: '#494740'
  inverse-surface: '#33302c'
  inverse-on-surface: '#f7efe9'
  outline: '#7a776f'
  outline-variant: '#cbc6bd'
  surface-tint: '#605e5b'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#1c1b19'
  on-primary-container: '#868380'
  inverse-primary: '#cac6c2'
  secondary: '#904d00'
  on-secondary: '#ffffff'
  secondary-container: '#fe9324'
  on-secondary-container: '#653500'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#1c1b1c'
  on-tertiary-container: '#868384'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e6e2de'
  primary-fixed-dim: '#cac6c2'
  on-primary-fixed: '#1c1b19'
  on-primary-fixed-variant: '#484644'
  secondary-fixed: '#ffdcc2'
  secondary-fixed-dim: '#ffb77b'
  on-secondary-fixed: '#2e1500'
  on-secondary-fixed-variant: '#6d3900'
  tertiary-fixed: '#e6e1e2'
  tertiary-fixed-dim: '#c9c5c6'
  on-tertiary-fixed: '#1c1b1c'
  on-tertiary-fixed-variant: '#484647'
  background: '#fff8f2'
  on-background: '#1e1b17'
  surface-variant: '#e8e1db'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.015em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  title-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  title-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.04em
  numeric-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.02em
  numeric-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system delivers a rugged, high-clarity instrument built for independent trade professionals—electricians, HVAC technicians, and plumbers working in challenging environments. The aesthetic rejects decorative distractions: no glassmorphism, no gradient washes, and no whimsical illustrations. Every surface, interaction, and glyph reflects utility, precision, and heavy-duty reliability.

The design movement is an uncompromising synthesis of **Industrial Utility** and **Modern Functionalism**. High contrast is preserved at all costs to guarantee effortless legibility under direct, harsh sunlight or within dimly lit crawlspaces and utility rooms. Visual elements communicate immediate operational status through calibrated signals rather than aesthetic flourishes. Tactile clarity is paramount: controls are bold, distinct, and spaced for gloved, one-handed field operation on Android devices.

## Colors

The color palette is built for rapid optical parsing and unyielding contrast:

- **Canvas & Structural Surfaces**: The base canvas rests on `#FAFAF9`, paired with crisp `#FFFFFF` card and sheet surfaces to enforce clear structural planes. Structural boundaries are held firmly by `#E4E2DE` (1px clean borders).
- **Text & Core Interactivity**: `#1C1B19` serves as the primary text and key interactive surface (primary buttons), providing maximum contrast ratios against light backgrounds. Supporting context, labels, and timestamps rely on `#57534E` for clear typographic hierarchy without loss of legibility.
- **Brand Accent**: `#E8820C` (Industrial Amber) is reserved strictly for operational telemetry: active navigation states, selected indicators, progress markers, and focused elements.
- **Semantic Field Tokens**:
  - **Success / Approved**: `#15803D`
  - **Warning / Pending / Sent**: `#B45309`
  - **Error / Refused / Urgent**: `#B91C1C`
  - **Info / Draft**: `#0369A1`

Tinted semantic backgrounds must maintain a minimum contrast ratio of 4.5:1 against text, utilizing 10% opacity fills of the corresponding semantic hue against pure white card surfaces.

## Typography

Inter powers the entire type system across all platforms to maximize optical legibility under direct sunlight.

- **Tabular Figures**: All financial items, parts counts, hour logs, and equipment specs must explicitly enforce `font-feature-settings: 'tnum' 1, 'cv05' 1`. This aligns numeric values cleanly across invoices, quotes, and work orders.
- **Hierarchy & Densities**: Heavy font weights (600 and 700) are leveraged liberally for job codes, customer names, and balances to ensure instant readability while standing or holding a device at arm's length.
- **Labels & Badges**: Small functional tags (e.g., "URGENT", "DRAFT") utilize `label-sm` with upper-case tracking to avoid text bleeding against high-contrast badge borders.

## Layout & Spacing

Field technicians interact with mobile devices under imperfect operating conditions. The spacing rhythm is anchored strictly to an 8dp baseline grid, with 4dp fractional adjustments for compact metadata tags.

- **Touch Targets**: All interactive elements (toggles, list items, icon buttons, form fields) enforce an inviolable minimum dimension of **48dp × 48dp** (optimally 56dp for high-frequency actions) to facilitate gloved or thumb-driven use.
- **Margins & Gutters**: Standard Android handset layouts implement a continuous 16dp (`1rem`) screen edge margin and 16dp column gutters. Tablet interfaces (e.g., mounted vehicle displays) transition to a 24dp screen margin with dual-pane master-detail splits.
- **Rhythm**: Vertical content grouping uses `space-xs` (4dp) between labels and data values, `space-sm` (8dp) within tightly related groupings, `space-md` (16dp) between distinct input fields and list items, and `space-lg` (24dp) separating high-level card sections.

## Elevation & Depth

This design system avoids soft, diffuse skeuomorphic shadows and vaporous blurs. Spatial distinction is achieved through **low-contrast structural outlines** and flat tonal layering:

- **Level 0 (Canvas)**: `#FAFAF9` background plane.
- **Level 1 (Cards, Modules, List Sheets)**: Pure `#FFFFFF` surface with a crisp, non-negotiable `1px solid #E4E2DE` border. Elevation shadows are absent by default to eliminate visual smear in bright ambient conditions.
- **Level 2 (Floating Action Buttons & Bottom Sheets)**: When z-axis separation is mechanically required (e.g., sticky action toolbars, drawer overlays), use a sharp, minimal drop: `0px 2px 4px rgba(28, 27, 25, 0.08)`, always bounded by the `1px solid #E4E2DE` border.
- **Level 3 (Modal Dialogs & Critical Alerts)**: Bounded by `1px solid #1C1B19` with a subtle offset: `0px 4px 12px rgba(28, 27, 25, 0.12)`.

## Shapes

The shape geometry balances durability with contemporary precision:

- **Buttons, Text Fields, and Small Elements**: Standardized at an exact **8dp corner radius** (`rounded-md`). This creates a chiseled, firm contour suited for tool software.
- **Cards, Modules, and Modals**: Standardized at an exact **12dp corner radius** (`rounded-lg`). The slight expansion in curvature softens content groupings without drifting into casual, toy-like roundness.
- **Status Tags & Chips**: Built with a **6dp corner radius** to distinguish functional taxonomy from clickable inputs.
- **Circles**: Constrained exclusively to floating action icons, avatar badges, and radio selectors.

## Components

### Buttons
- **Primary**: Solid `#1C1B19` fill, `#FFFFFF` text, 8dp corner radius, height 48dp (standard) or 56dp (terminal actions like "Complete Job"). Active pressed state: `#33312E`.
- **Secondary**: `#FFFFFF` surface, 1px border in `#E4E2DE`, `#1C1B19` text, 8dp radius. Active pressed state: `#FAFAF9`.
- **Accent / Utility Action**: Solid `#E8820C` fill, `#FFFFFF` text, 8dp radius. Used exclusively for singular primary triggers (e.g., "Start Navigation", "Record Clock-In").
- **Destructive**: 1px border in `#B91C1C`, `#B91C1C` text, transparent or white background.

### Cards
- Pure `#FFFFFF` fill, 12dp radius, 1px solid `#E4E2DE` border. Padding: 16dp (`space-md`). No default drop shadow.
- Status cards utilize a 4dp solid left indicator stroke corresponding to the work order's semantic state (`#15803D`, `#B45309`, `#B91C1C`, or `#0369A1`).

### Form Inputs & Text Fields
- Min height 52dp. Clean `#FFFFFF` fill, 8dp radius, 1px solid `#E4E2DE` border.
- Active/Focused state: 2px solid `#1C1B19` (or `#E8820C` for field highlights).
- Labels are rendered permanently outside or top-pinned in `label-md` (`#57534E`) to prevent vanishing field context during manual entry. Monospaced numeric styling (`tnum`) is standard for all metric, rate, and dimension fields.

### Status Badges & Chips
- Filter chips: 36dp height, 6dp radius, 1px border `#E4E2DE`, background `#FFFFFF`, text `#1C1B19`. Selected state: `#1C1B19` background, `#FFFFFF` text.
- Semantic Status Badges: Height 24dp, horizontal padding 8dp, 4dp radius. Solid 10% opacity tint background with matching 100% semantic text (e.g., Pending Invoice: background `rgba(180, 83, 9, 0.10)`, text `#B45309`).

### Checkboxes & Radios
- Size: 24dp × 24dp centered inside a 48dp × 48dp touch container.
- Unchecked: 2px solid `#57534E` border, transparent center.
- Checked: `#1C1B19` background with `#FFFFFF` glyph. Checkbox corner radius is 4dp; radio is full circle.

### Lists & Table Items
- Line items enforce a 56dp minimum row height.
- Separators: 1px continuous hairline (`#E4E2DE`).
- Tap feedback: Instant `#F5F5F4` ripple without lingering fade animations to maintain snappy instrument responsiveness.
