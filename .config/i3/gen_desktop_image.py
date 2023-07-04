import PIL
import PIL.Image
import PIL.ImageFont
import PIL.ImageOps
import PIL.ImageDraw
import os

PIXEL_ON = 255  # PIL color to use for "on"
PIXEL_OFF = 0  # PIL color to use for "off"
INIT_READING = "### Init Read for Desktop Image ###"
END_READING = "### End Read for Desktop Image ###"
CHANGE_STRING_LIST = [("bindsym ", ""), ("$mod", "Win"), (" exec ", " => ")]

def main():

    i3home = os.getenv('I3_FOLDER')
    image = text_image(str(i3home) + '/config', '/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf')
    image.save(str(i3home) + '/desktop.png')

def command_filter(line, prev_line):
    for item in CHANGE_STRING_LIST:
        line = line.replace(item[0], item[1])

    if prev_line.startswith("#"):
        line = add_comment(line, prev_line.split('#')[1])

    if " => " in line:
        line_arr = line.split(" => ")
        line = line_arr[0].upper() + " => " + line_arr[1]
    return line

def add_comment(line, prev_line):
    command = line.split(" => ")
    description = prev_line.replace('#', '')
    return description.strip() + " => " + command[0].replace('\n', '')

def get_eligible_lines(arr):
    is_reading = False
    header_lines = []
    lines_list = []
    prev_line = ''
    cur_line = ''

    header_lines.append("--- Desktop Main Shortcuts ---")
    header_lines.append("______________________________")
    for line in arr:
        if line.rstrip() == INIT_READING:
            is_reading = True
        elif line.rstrip() == END_READING:
            is_reading = False
        elif is_reading == True:
            cur_line = command_filter(line, prev_line)
            if not cur_line.startswith('#'):
                lines_list.append(cur_line)
            prev_line = line

    lines_list.sort()
    lines_list = header_lines + lines_list
    return lines_list

def text_image(text_path, font_path=None):

    """Convert text file to a grayscale image with black characters on a white background.

    arguments:
    text_path - the content of this file will be converted to an image
    font_path - path to a font file (for example impact.ttf)
    """
    grayscale = 'L'
    # parse the file into lines
    with open(text_path) as text_file:  # can throw FileNotFoundError
        lines = tuple(l.rstrip() for l in get_eligible_lines(text_file.readlines()))

    # choose a font (you can see more detail in my library on github)
    large_font = 30  # get better resolution with larger size
    font_path = font_path or 'cour.ttf'  # Courier New. works in windows. linux may need more explicit path
    try:
        font = PIL.ImageFont.truetype(font_path, size=large_font)
    except IOError:
        font = PIL.ImageFont.load_default()

    # make the background image based on the combination of font and lines
    pt2px = lambda pt: int(round(pt * 96.0 / 36))  # convert points to pixels
    max_width_line = max(lines, key=lambda s: font.getsize(s)[0])
    # max height is adjusted down because it's too large visually for spacing
    test_string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    max_height = pt2px(font.getlength(test_string)[1])
    max_width = pt2px(font.getlength(max_width_line)[0])

    height = max_height * len(lines)  # perfect or a little oversized
    width = int(round(max_width))  # a little oversized
    image = PIL.Image.new(grayscale, (width, height), color=PIXEL_OFF)
    draw = PIL.ImageDraw.Draw(image)

    # draw each line of text
    vertical_position = 3
    horizontal_position = 3
    line_spacing = int(round(max_height * 0.6))  # reduced spacing seems better
    for line in lines:
        draw.text((horizontal_position, vertical_position),
                  line, fill=PIXEL_ON, font=font)
        vertical_position += line_spacing
    # crop the text
    c_box = PIL.ImageOps.invert(image).getbbox()
    image = image.crop(c_box)

    return image


if __name__ == '__main__':
    main()
