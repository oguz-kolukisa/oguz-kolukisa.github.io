# Audio Files

This directory contains audio files for the terminal website.

## Required Audio Files

Place the following audio files in this directory:

### 1. `keypress.mp3` or `keypress.wav`
- **Purpose:** Mechanical keyboard typing sound
- **Trigger:** When user types in the terminal input
- **Recommended:** Short, crisp click sound (~50-100ms)
- **Volume:** Set to 30% in code

### 2. `click.mp3` or `click.wav`
- **Purpose:** UI interaction feedback
- **Trigger:** Button clicks, copy actions, command execution
- **Recommended:** Subtle "bloop" or confirmation sound
- **Volume:** Set to 40% in code

### 3. `hover.mp3` or `hover.wav`
- **Purpose:** Button hover feedback
- **Trigger:** Mouse hover over interactive elements
- **Recommended:** Very subtle, soft sound
- **Volume:** Set to 20% in code

## File Format Recommendations

- **Format:** MP3 (better compatibility) or WAV (higher quality)
- **Size:** Keep files small (<50KB each) for fast loading
- **Sample Rate:** 44.1kHz or 48kHz
- **Bit Rate:** 128kbps for MP3 is sufficient

## Free Sound Resources

You can find suitable sounds at:
- [Freesound.org](https://freesound.org/)
- [Zapsplat.com](https://www.zapsplat.com/)
- [Soundbible.com](http://soundbible.com/)

Search terms: "keyboard click", "mechanical keyboard", "UI click", "button hover"

## Implementation Notes

- Audio is muted by default if user has set it previously
- Mute toggle button is in the terminal header (🔈/🔇)
- Audio autoplay may be blocked by browsers until user interaction
- Errors are silently caught to avoid disrupting the user experience
