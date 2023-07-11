from mlxtend.data import loadlocal_mnist
import numpy as np
import statistics as stat
import string

'''
Note: Need mlxtend for this script to work. Install via (pip3 install mlxtend)
-open all files
-getline count
-go through each line
    -if we want that number
        -grab all pixels, get row stdev, col stdev, num bright pix, number trying to draw
        -write data to file

28*28 pixel imgs of handwritten digits
accomponied by labels of which digit is being written        

Ex. 5x5 img
Label: 7
0  255  253  0  0  
0  0    255  0  0  
0  0    252  0  0  
0  0    255  0  0  
0  0    251  0  0  

Providing different combonations of inputs (descriptions of the img)
Giving an output that is the label (intended handwritten digit)

Testing and training data was aquired from Mnist Handwritten Data
    Source: https://yann.lecun.com/exdb/mnist/
    Y. LeCun and C. Cortes. Mnist handwritten digit database. AT&T Labs [Online]. Available: https://yann. lecun. com/exdb/mnist, 2010.

Test and train data will be given to NeuroModeler to train a neural network for optical character recognition (OCR)
'''

#---------------------CHANGE HERE----------------------------------------------
labelsWant = [0,1,2,3,4,5,6,7,8,9]  


INDIVIDUAL_ROW_PIX_COUNT = True  #28
INDIVIDUAL_ROW_STDEVS = False #28
INDIVIDUAL_COL_PIX_COUNT = False #28
INDIVIDUAL_COL_STDEVS = False #28
TOTAL_BRIGHT_PIX_COUNT = False #1
AVG_STD_ROWS = False #1
AVG_STD_COLS = False #1

MAX_TRAIN = 60000
MAX_TEST = 10000
BRIGHTNESS_THRESHOLD = 128
HEIGHT = 28
WIDTH = 28

pathToData = ""
testIMGsFILE = pathToData + "t10k-images.idx3-ubyte" 
testLABsFILE = pathToData + "t10k-labels.idx1-ubyte"
trainIMGsFILE = pathToData + "train-images.idx3-ubyte"
trainLABsFILE = pathToData + "train-labels.idx1-ubyte"
outName = "3input"
outputTest = pathToData + outName + "-stat_test.dat"
outputTrain = pathToData + outName + "-stat_train.dat"

#-------------------------DO NOT CHANGE BELOW----------------------------------

inputs = []
output = ""
current_image = []
current_label = 0
current_set = "train"

trainImages, trainLabels = loadlocal_mnist(trainIMGsFILE, trainLABsFILE)
testImages, testLabels = loadlocal_mnist(testIMGsFILE, testLABsFILE)

trainCount = trainLabels.shape[0]
testCount = testLabels.shape[0]
totalCount = trainCount + testCount

trainOutFile = open(outputTrain, "w")
testOutFile = open(outputTest, "w")

outFile = trainOutFile

def indiv_row_pix_count():
    #Calc amount of bright pixels in each row
    pixCount = 0
    if INDIVIDUAL_ROW_PIX_COUNT:
        #print("Calc amount of bright pixels in each row" + str(set))
        for row in range(HEIGHT):
            for col in range(WIDTH):
                if current_image[row][col] >= BRIGHTNESS_THRESHOLD:
                    pixCount += 1
            pixPercentage = pixCount/WIDTH
            pixCount = 0
            inputs.append(pixPercentage) #Adds 28 inputs
            
def indiv_col_pix_count():
    #Calc amount of bright pixels in each col
    if INDIVIDUAL_COL_PIX_COUNT:
        pixCount = 0
        #print("Calc amount of bright pixels in each col")
        for col in range(WIDTH):
            for row in range(HEIGHT):
                if current_image[row][col] >= BRIGHTNESS_THRESHOLD:
                    pixCount += 1
            pixPercentage = pixCount/WIDTH
            pixCount = 0
            inputs.append(pixPercentage) #Adds 28 inputs
            
def indiv_row_stdev():
    #Calc stdev for each row
    if INDIVIDUAL_ROW_STDEVS:
        #print("Calc stdev for each row")
        rowVals = []
        for row in range(HEIGHT):
            for col in range(WIDTH):
                    rowVals.append(current_image[row][col])
            inputs.append(np.std(rowVals)) #Adds 28 inputs 
            rowVals = []
        
def indiv_col_stdev():
    #Calc stdev for each col
    if INDIVIDUAL_COL_STDEVS:
        #print("Calc stdev for each col")
        colVals = []
        for col in range(WIDTH):
            for row in range(HEIGHT):
                colVals.append(current_image[row][col])
            inputs.append(np.std(colVals)) #Adds 28 inputs 
            colVals = []
        
def total_bright_pix_count():
    #Calc total amount of bright pixelsin image
    if TOTAL_BRIGHT_PIX_COUNT:
        #print("Calc total amount of bright pixels in image")
        pixCount = 0
        for row in range(HEIGHT):
            for col in range(WIDTH):
                if current_image[row][col] >= BRIGHTNESS_THRESHOLD:
                    pixCount += 1
        pixPercentage = pixCount/(HEIGHT*WIDTH)
        inputs.append(pixPercentage) #Adds 1 inputs

def avg_std_rows():
    #Calc avg stdev for rows
    if AVG_STD_ROWS:
        #print("Calc avg stdev for rows")
        stdev_adder = 0
        for row in current_image:
            stdev_adder += np.std(row)
        avg_std = stdev_adder/(HEIGHT)
        inputs.append(avg_std) #Adds 1 inputs      

def avg_std_cols():
    #Calc avg stdev for cols
    if AVG_STD_COLS:
        #print("Calc avg stdev for cols")
        stdev_adder = 0
        np.transpose(current_image)
        for col in current_image:
            stdev_adder += np.std(col)
        avg_std = stdev_adder/(WIDTH)
        inputs.append(avg_std) #Adds 1 inputs            
          
#------------------------------------------------------------------------

#Open up traindata and testData


set = 0
while(True): #EACH IMAGE
    
    if set > MAX_TRAIN and current_set == "train":
        set = trainCount
        current_set = "test"
        outFile = trainOutFile
    if set > trainCount + MAX_TEST - 1:
        print("DONE WITH TEST")
        break

    #Grab next image

    if (set < trainCount): #IN TRAIN DATA
        if trainLabels[set] in labelsWant: #IF WANTED
            #Reshape each MNIST image list into numpy 2D array
            current_image = np.reshape(trainImages[set], (WIDTH, HEIGHT))
            current_label = int(trainLabels[set])
            outFile = trainOutFile
        else: #IF NOT WANTED, SKIP
            set += 1
            continue    
    else: #IN TEST DATA
        if testLabels[set - trainCount] in labelsWant: #IF WANTED
            #Reshape each MNIST image list into numpy 2D array
            current_image = np.reshape(testImages[set - trainCount], (WIDTH, HEIGHT))
            current_label = int(testLabels[set - trainCount])
            outFile = testOutFile
        else: #IF NOT WANTED, SKIP
            set += 1
            continue

    #THESE WILL ONLY RUN IF SET UP TOP
    indiv_row_pix_count()
    indiv_col_pix_count()
    indiv_row_stdev()
    indiv_col_stdev()
    total_bright_pix_count()
    avg_std_rows()
    avg_std_cols()

    inputString = ""
    for input in inputs:
        inputString += str(input) + " "
    inputs = []    


    for i in range(current_label):
        output += "0 "
    output += "1"
    for i in range(9-current_label):
        output += " 0"
    
    
    outFile.write(inputString + output + "\n")
    output = ""

    set += 1
    print(str(set))


trainOutFile.close
testOutFile.close
