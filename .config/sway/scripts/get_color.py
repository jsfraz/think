#!/usr/bin/env python3

# sudo pacman -S python-pillow

import sys
from PIL import Image
from collections import Counter
import colorsys

def get_dominant_color(image_path):
    """Gets the dominant color from an image."""
    img = Image.open(image_path)
    img = img.convert('RGB')
    img = img.resize((150, 150))  # Reduce size for faster processing
    
    pixels = list(img.getdata())
    
    # Filter out very dark and very light pixels
    pixels = [p for p in pixels if sum(p) > 50 and sum(p) < 700]
    
    if not pixels:
        return (128, 128, 128)  # Fallback
    
    # Find the most common color
    most_common = Counter(pixels).most_common(1)[0][0]
    return most_common

def rgb_to_hex(rgb):
    """Converts RGB tuple to hex color code."""
    return "#{:02x}{:02x}{:02x}".format(rgb[0], rgb[1], rgb[2])

def color_name_to_hex(color_name):
    """Converts color name to hex code."""
    color_map = {
        "red": "#e74c3c",
        "orange": "#e67e22",
        "yellow": "#f39c12",
        "green": "#27ae60",
        "teal": "#16a085",
        "blue": "#3498db",
        "purple": "#9b59b6",
        "pink": "#e91e63"
    }
    return color_map.get(color_name.lower(), "#808080")

def rgb_to_color_name(rgb):
    """Converts RGB to color name."""
    r, g, b = rgb
    h, s, v = colorsys.rgb_to_hsv(r/255.0, g/255.0, b/255.0)
    
    # Convert hue (0-1) to degrees (0-360)
    hue = h * 360
    
    # Map hue to colors
    if hue < 15 or hue >= 345:
        return "red"
    elif 15 <= hue < 35:
        return "orange"
    elif 35 <= hue < 65:
        return "yellow"
    elif 65 <= hue < 150:
        return "green"
    elif 150 <= hue < 180:
        return "teal"
    elif 180 <= hue < 260:
        return "blue"
    elif 260 <= hue < 290:
        return "purple"
    elif 290 <= hue < 330:
        return "pink"
    elif 330 <= hue < 345:
        # Area between pink and red - decision based on brightness
        if v > 0.6:
            return "pink"
        else:
            return "red"
    else:
        return "blue"  # Fallback

def main():
    if len(sys.argv) < 2:
        print("Usage: python get_color.py [-hex] [-color2hex] <image_path|color_name>", file=sys.stderr)
        sys.exit(1)
    
    hex_output = False
    color2hex_mode = False
    target = None
    
    # Parse arguments
    for i in range(1, len(sys.argv)):
        if sys.argv[i] == "-hex":
            hex_output = True
        elif sys.argv[i] == "-color2hex":
            color2hex_mode = True
        else:
            target = sys.argv[i]
    
    if not target:
        print("Usage: python get_color.py [-hex] [-color2hex] <image_path|color_name>", file=sys.stderr)
        sys.exit(1)
    
    try:
        if color2hex_mode:
            # Convert color name to hex
            hex_code = color_name_to_hex(target)
            print(hex_code)
        else:
            # Get dominant color from image
            dominant_rgb = get_dominant_color(target)
            
            if hex_output:
                print(rgb_to_hex(dominant_rgb))
            else:
                color_name = rgb_to_color_name(dominant_rgb)
                print(color_name)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()