"""
Isaac Violette
ECE 498
6/29/23
"""

"""
    Structure of idx3-ubyte file:
    Magic Number (4 bytes): 2501 for idx3 files
    Number of Images (4 bytes)
    Number of Rows (4 bytes): number of pixels in each row (should be 28)
    Number of Columns (4 bytes): number of pixels in each column (should be 28) 
    Image Data: Remaining bytes is image data. Each pixel is represented in a single byte
    indicating grayscale intensity     
"""

import struct #Interpret bytes as packed bianry data
import numpy as np

def convert_mnist_images(input_file, output_file):

    #Read binary data from input file
    with open(input_file, 'rb') as f:
        # Read the header information

        # '>I' is big endian unsigned int
        magic_number = struct.unpack('>I', f.read(4))[0] #returns first element in returned tuple
        num_images = struct.unpack('>I', f.read(4))[0]
        num_rows = struct.unpack('>I', f.read(4))[0]
        num_cols = struct.unpack('>I', f.read(4))[0]
        
        # Verify that the input file is in the correct format
        if magic_number != 2051:
            print("Invalid magic number")
            exit()
        
        # Create a new header for the output file
        new_num_rows = 7
        new_num_cols = 7
        new_magic_number = 2051
        new_num_images = num_images

        # Write the header information to the output file
        with open(output_file, 'wb') as output_f:
            #Write the 16 bytes of meta data
            output_f.write(struct.pack('>I', new_magic_number))
            output_f.write(struct.pack('>I', new_num_images))
            output_f.write(struct.pack('>I', new_num_rows))
            output_f.write(struct.pack('>I', new_num_cols))

            # Iterate through each image in the input file
            for _ in range(num_images):
                # Read the 28x28 pixel image
                # Read the raw pixel data from the input file and convert it into a tuple 
                # of unsigned byte values, representing the pixel intensities of a single image
                image_data = struct.unpack('B' * (num_rows * num_cols), f.read(num_rows * num_cols))
                # Make 2d array for easier manipulation
                image_array = np.array(image_data).reshape((num_rows, num_cols))

                # Convert the image to 7x7 by averaging the corresponding pixels
                # Completed in 4x4 blocks
                new_image_array = np.zeros((new_num_rows, new_num_cols))
                for i in range(new_num_rows):
                    for j in range(new_num_cols):
                        new_image_array[i, j] = np.mean(image_array[i*4:i*4+4, j*4:j*4+4])

                # Flatten and write the new image to the output file
                output_f.write(struct.pack('B' * (new_num_rows * new_num_cols), *new_image_array.astype(np.uint8).flatten()))


# Usage example
convert_mnist_images('t10k-images.idx3-ubyte', 't10k-images-7x7.idx3-ubyte')
