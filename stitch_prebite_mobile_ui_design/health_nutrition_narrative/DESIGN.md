---
name: Health & Nutrition Narrative
colors:
  surface: '#fcf9f8'
  surface-dim: '#dcd9d9'
  surface-bright: '#fcf9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f2'
  surface-container: '#f0eded'
  surface-container-high: '#eae7e7'
  surface-container-highest: '#e5e2e1'
  on-surface: '#1b1b1b'
  on-surface-variant: '#3e4a3f'
  inverse-surface: '#313030'
  inverse-on-surface: '#f3f0ef'
  outline: '#6e7a6e'
  outline-variant: '#becabc'
  surface-tint: '#006d33'
  primary: '#006b32'
  on-primary: '#ffffff'
  primary-container: '#0e8642'
  on-primary-container: '#f7fff3'
  inverse-primary: '#73dc8d'
  secondary: '#0f6d37'
  on-secondary: '#ffffff'
  secondary-container: '#9ff6b2'
  on-secondary-container: '#19733d'
  tertiary: '#535f58'
  on-tertiary: '#ffffff'
  tertiary-container: '#6b7770'
  on-tertiary-container: '#f5fff7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#8ff9a7'
  primary-fixed-dim: '#73dc8d'
  on-primary-fixed: '#00210b'
  on-primary-fixed-variant: '#005225'
  secondary-fixed: '#9ff6b2'
  secondary-fixed-dim: '#84d998'
  on-secondary-fixed: '#00210c'
  on-secondary-fixed-variant: '#005227'
  tertiary-fixed: '#d9e6dd'
  tertiary-fixed-dim: '#bdcac1'
  on-tertiary-fixed: '#131e19'
  on-tertiary-fixed-variant: '#3e4943'
  background: '#fcf9f8'
  on-background: '#1b1b1b'
  surface-variant: '#e5e2e1'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  title-lg:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
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
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  button:
    fontFamily: Inter
    fontSize: 16px
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
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  gutter: 16px
  margin-mobile: 16px
  margin-desktop: 64px
---

## Brand & Style

The design system is rooted in **Modern Minimalism** with a focus on clinical clarity and organic warmth. It is designed for users seeking a trustworthy, professional-grade tool for health and food analysis without the intimidating aesthetic of traditional medical software.

The emotional response should be one of "effortless health"—clean, airy, and organized. By utilizing a "High-Contrast / Bold" approach to typography paired with expansive whitespace, the UI directs focus toward data visualization and nutritional insights. The aesthetic is "Fresh-Tech," blending the precision of software engineering with the softness of nature.

## Colors

The palette is built on a "Verdant Spectrum" that emphasizes vitality and safety. 

- **Primary Green (#168A45):** Used for key brand moments and success states. It represents natural growth and nutritional balance.
- **Dark Green (#0B6B36):** Reserved for high-priority actions and heavy typography to ensure AA accessibility and a sense of authority.
- **Light Green (#EAF7EE):** Applied as a "soft wash" for background sections and highlight chips, reducing visual fatigue.
- **Neutrals:** The background remains a pure white to maximize the "Premium" feel, while borders utilize a specific gray-green tint to maintain the organic theme even in the structural elements.

## Typography

This design system uses **Inter** exclusively to leverage its exceptional legibility and systematic feel. 

- **Headlines:** Use heavy weights (700) with tight letter spacing for a modern, confident brand presence. 
- **Metadata:** Smaller text levels (`label-md`) should utilize medium weights (500) and increased letter spacing to ensure readability even at 12px.
- **Hierarchy:** Maintain a clear distinction between the "Dark Green" used for primary headers and "Muted Gray/Green" used for body text to create a natural eye-path through dense nutritional data.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid** model centered on an 8px rhythmic scale. 

- **Desktop:** 12-column grid with 24px gutters. Content is capped at a max-width of 1280px for optimal readability of long-form food analysis reports.
- **Mobile:** 4-column grid with 16px margins. 
- **Spacing Rhythm:** Use `lg` (24px) for spacing between distinct cards or sections, and `sm` (8px) for internal element grouping (e.g., label to input field).

## Elevation & Depth

Visual hierarchy is achieved through **Tonal Layers** and **Ambient Shadows**. 

1. **Base Layer:** Pure White (#FFFFFF) background.
2. **Surface Layer:** Cards and containers use the same white background but are defined by a 1px border (#E2E7E3) and a "Soft Bloom" shadow.
3. **Shadow Specs:** Shadows should be highly diffused, using a 10% opacity of the Dark Green (#0B6B36) rather than pure black, ensuring the elevation feels integrated with the brand palette.
4. **Interactive States:** On hover, elements should transition from a flat border to a slightly deeper shadow (8px Y-offset, 16px blur) to simulate physical lift.

## Shapes

The shape language is **Rounded**, conveying friendliness and approachability. 

- **Standard Elements:** Buttons and Input fields use a 12px radius.
- **Containers:** Cards and modal sheets use a 16px radius (`rounded-lg`) to create a distinct, softer frame for content.
- **Visual Cues:** Progress bars and selection indicators should use a fully rounded (pill) style to distinguish them from structural containers.

## Components

- **Buttons:** Primary buttons use the Dark Green background with White text. Secondary buttons use the Light Green background with Primary Green text. Always use 12px corner radius and 16px horizontal padding.
- **Cards:** White background, 1px #E2E7E3 border, 16px corner radius. Internal padding should be a minimum of 24px to maintain an "airy" feel.
- **Input Fields:** 12px corner radius with the #E2E7E3 border. On focus, the border transitions to Primary Green (#168A45) with a 2px stroke.
- **Chips/Badges:** Used for food categories (e.g., "Vegan", "High Protein"). These utilize the Light Green background with the Primary Green text in `label-md` typography.
- **Data Visuals:** Donut charts and progress rings should use Primary Green for active segments and the Light Green for the empty track.
- **Lists:** Clean rows separated by a 1px horizontal rule (#E2E7E3), with generous vertical padding (16px) to accommodate touch targets.