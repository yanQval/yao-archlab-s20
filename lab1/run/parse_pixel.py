try:
    from PIL import Image
except ImportError:
    import Image
import sys

if len(sys.argv) < 2:
    print('Usage %s output.pixel [output.img]' % (sys.argv[0]))
    sys.exit(0)

file = open(sys.argv[1], "r")
meta_line = file.readline()
meta_arr = meta_line.split(' ')
height = int(meta_arr[0])
width = int(meta_arr[1])

img = Image.new('L', (width, height)) # Read a grayscale image
data = img.load()
i = 0
for line in file:
    pixel_arr = line.split(' ')
    for j in range(width):
        data[j, i] = int(pixel_arr[j]) # img data is put in [width_j, height_i] order in PIL
    i = i + 1

img.show()
outputfile = "image-out.jpg"
if len(sys.argv) > 2:
    outputfile = sys.argv[2]
img.save(outputfile)
