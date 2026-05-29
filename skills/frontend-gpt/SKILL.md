---
name: frontend-gpt
description: Frontend development guidance for GPT agents building polished applications, websites, dashboards, games, and UI components. Use when GPT/Codex is asked to create, refine, style, verify, or ship any frontend experience, especially when visual design quality, responsive behavior, interaction ergonomics, or local preview verification matter.
---

# Frontend GPT

Use these instructions when building applications with a frontend experience.

## Build With Empathy

- If working with an existing design or design framework, pay careful attention to existing conventions and keep new work consistent with the application's framework and design language.
- Think deeply about the audience and use that to decide features, layout, components, visual style, on-screen text, and interaction patterns. The result should feel rich and sophisticated.
- Tailor frontend design to the domain and subject matter. SaaS, CRM, and operational tools should feel quiet, utilitarian, and work-focused: avoid oversized hero sections, decorative card-heavy layouts, and marketing-style composition; prioritize dense but organized information, restrained styling, predictable navigation, and interfaces built for scanning, comparison, and repeated action. Games can be more illustrative, expressive, animated, and playful.
- Make common workflows ergonomic, efficient, and comprehensive, so users can seamlessly navigate in and out of different views and pages.

## Interaction And Controls

- Use icons in buttons for tools, swatches for color, segmented controls for modes, toggles or checkboxes for binary settings, sliders/steppers/inputs for numeric values, menus for option sets, tabs for views, and text or icon-plus-text buttons only for clear commands unless otherwise specified.
- Keep cards at 8px border radius or less unless the existing design system requires otherwise.
- Do not use rounded rectangular UI elements with text inside when a familiar symbol or icon would work better, such as arrow icons for undo/redo, B/I icons for bold/italic, and save/download/zoom icons.
- Build tooltips that name or describe unfamiliar icons on hover.
- Use lucide icons inside buttons whenever one exists. If an application already has an icon library, use that library.
- Build feature-complete controls, states, and views that the target user would naturally expect.
- Do not use visible in-app text to describe the application's features, functionality, keyboard shortcuts, styling, visual elements, or how to use the application.

## Experience Structure

- Do not make a landing page unless absolutely required. When asked for a site, app, game, or tool, build the actual usable experience as the first screen, not marketing or explanatory content.
- For hero pages, use a relevant image, generated bitmap image, or immersive full-bleed interactive scene as the background with text over it, not in a card.
- Do not use split text/media hero layouts where a card is one side and text is on another side.
- Do not put hero text or the primary experience in a card.
- Do not use a gradient/SVG hero page, and do not create an SVG hero illustration when a real or generated image can carry the subject.
- On branded, product, venue, portfolio, or object-focused pages, make the brand/product/place/object a first-viewport signal, not only tiny nav text or an eyebrow.
- Hero content must leave a hint of the next section visible on every mobile and desktop viewport, including wide desktop.
- For landing-page heroes, make the H1 the brand/product/place/person name or a literal offer/category. Put descriptive value props in supporting copy, not the headline.

## Visual Assets

- Websites and games must use visual assets. Use image search, known relevant images, or generated bitmap images instead of SVGs unless making a game.
- Primary images and media should reveal the actual product, place, object, state, gameplay, or person.
- Avoid dark, blurred, cropped, stock-like, or purely atmospheric media when the user needs to inspect the real thing.
- For highly specific game assets, use custom SVG, Three.js, canvas, or other code-native assets when appropriate.

## Games And 3D

- For games or interactive tools with well-established rules, physics, parsing, or AI engines, use a proven existing library for the core domain logic unless the user explicitly asks for a from-scratch implementation.
- Use Three.js for 3D elements.
- Make the primary 3D scene full-bleed or unframed, not inside a decorative card or preview container.
- Before finishing 3D work, verify with Playwright screenshots and canvas-pixel checks across desktop and mobile viewports that it is nonblank, correctly framed, interactive or moving, and that referenced assets render as intended without overlapping.

## Layout Discipline

- Do not put UI cards inside other cards.
- Do not style page sections as floating cards. Use full-width bands or unframed layouts with constrained inner content.
- Use cards only for individual repeated items, modals, and genuinely framed tools.
- Do not add discrete orbs, gradient orbs, or bokeh blobs as decoration or backgrounds.
- Make sure text fits within its parent UI element on all mobile and desktop viewports. Move it to a new line if needed, and if it still does not fit, use dynamic sizing so the longest word fits.
- Ensure text does not occlude preceding or subsequent content.
- Check that text inside buttons and cards looks professionally designed and polished.
- Match display text to its container: reserve hero-scale type for true heroes, and use smaller, tighter headings inside compact panels, cards, sidebars, dashboards, and tool surfaces.
- Define stable dimensions with responsive constraints such as aspect-ratio, grid tracks, min/max, or container-relative sizing for fixed-format UI elements like boards, grids, toolbars, icon buttons, counters, and tiles so hover states, labels, icons, pieces, loading text, and dynamic content cannot resize or shift layout.
- Do not scale font size with viewport width.
- Keep letter spacing at 0, not negative.
- Make sure UI elements and on-screen text do not overlap incoherently. Treat overlap as a serious user-experience problem.

## Color And Theme

- Do not make one-note palettes.
- Avoid UIs dominated by variations of a single hue family.
- Limit dominant purple or purple-blue gradients, beige/cream/sand/tan, dark blue/slate, and brown/orange/espresso palettes.
- Scan CSS colors before finalizing and revise if the page reads as one of these themes.

## Local Preview

- When building a site or app that needs a dev server to run properly, start the local dev server after implementation and give the user the URL.
- If the preferred port is already in use, use another port.
- For a website where opening the HTML file directly works, do not start a dev server. Give the user a link to the HTML file instead.
