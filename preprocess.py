from mlxtend.data import loadlocal_mnist
import numpy as np
import statistics as stat
import string

'''
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
labelsWant = [0,12,3,4,5,6,7,8,9]  


INDIVIDUAL_ROW_PIX_COUNT = True  #28
INDIVIDUAL_ROW_STDEVS = True #28
INDIVIDUAL_COL_PIX_COUNT = True #28
INDIVIDUAL_COL_STDEVS = True #28
TOTAL_BRIGHT_PIX_COUNT = True #1
SUM_ROW_STDEVS = True #1
SUM_COL_STDEVS = True #1
ALL_PIXELS = True #784

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
outputTest = pathToData + "stat_test.dat"
outputTrain = pathToData + "stat_train.dat"

#-------------------------DO NOT CHANGE BELOW----------------------------------

inputs = []
output = ""

def indiv_row_pix_count(set):
    #Calc amount of bright pixels in each row
    pixCount = 0
    if INDIVIDUAL_ROW_PIX_COUNT:
        #print("Calc amount of bright pixels in each row" + str(set))
        for row in range(HEIGHT):
            for col in range(WIDTH):
                if set < trainCount and trainImages[set][row + WIDTH*col] >= BRIGHTNESS_THRESHOLD: #Compiling traindata
                    pixCount += 1
                if not set < trainCount and testImages[set-trainCount][row + WIDTH*col] >= BRIGHTNESS_THRESHOLD: #Compiling testdata
                    pixCount += 1
            pixPercentage = pixCount/WIDTH
            pixCount = 0
            inputs.append(pixPercentage) #Adds 28 inputs
            
                


def indiv_col_pix_count(set):
    #Calc amount of bright pixels in each col
    
    if INDIVIDUAL_COL_PIX_COUNT:
        pixCount = 0
        #print("Calc amount of bright pixels in each col")
        for col in range(WIDTH):
            for row in range(HEIGHT):
                if set < trainCount and trainImages[set][row + HEIGHT*col] >= BRIGHTNESS_THRESHOLD: #Compiling traindata
                    pixCount += 1
                if not set < trainCount and testImages[set-trainCount][row + HEIGHT*col] >= BRIGHTNESS_THRESHOLD: #Compiling testdata
                    pixCount += 1
            pixPercentage = pixCount/WIDTH
            pixCount = 0
            inputs.append(pixPercentage) #Adds 28 inputs
            

        
def indiv_row_stdev(set):
    #Calc stdev for each row
    if INDIVIDUAL_ROW_STDEVS:
        #print("Calc stdev for each row")
        rowVals = []
        for row in range(HEIGHT):
            for col in range(WIDTH):
                if set < trainCount: #Compiling traindata
                    rowVals.append(trainImages[set][row + WIDTH*col])
                if not set < trainCount: #Compiling testdata
                    rowVals.append(testImages[set-trainCount][row + WIDTH*col])
            inputs.append(np.std(rowVals)) #Adds 28 inputs 
            rowVals = []
        
def indiv_col_stdev(set):
    #Calc stdev for each col
    if INDIVIDUAL_COL_STDEVS:
        #print("Calc stdev for each col")
        colVals = []
        for col in range(WIDTH):
            for row in range(HEIGHT):
                if set < trainCount: #Compiling traindata
                    colVals.append(trainImages[set][row + HEIGHT*col])
                if not set < trainCount: #Compiling testdata
                    colVals.append(testImages[set-trainCount][row + HEIGHT*col])
            inputs.append(np.std(colVals)) #Adds 28 inputs 
            colVals = []
        
def total_bright_pix_count(set):
    #Calc total amount of bright pixelsin image
    if TOTAL_BRIGHT_PIX_COUNT:
        #print("Calc total amount of bright pixels in image")
        pixCount = 0
        for row in range(HEIGHT):
            for col in range(WIDTH):
                if set < trainCount and trainImages[set][row + WIDTH*col] >= BRIGHTNESS_THRESHOLD: #Compiling traindata
                    pixCount += 1
                if not set < trainCount and testImages[set-trainCount][row + WIDTH*col] >= BRIGHTNESS_THRESHOLD: #Compiling testdata
                    pixCount += 1
        pixPercentage = pixCount/(HEIGHT*WIDTH)
        inputs.append(pixPercentage) #Adds 28 inputs
        

def sum_row_stdev(set):
    #Calc sum of stdev from each row
    if SUM_ROW_STDEVS:
        #print("Calc sum of stdev from each row " + str(set))
        rowVals = []
        sum = 0
        for row in range(HEIGHT):
            for col in range(WIDTH):
                if set < trainCount: #Compiling traindata
                    rowVals.append(trainImages[set][row + WIDTH*col])
                if not set < trainCount: #Compiling testdata
                    rowVals.append(testImages[set-trainCount][row + WIDTH*col])
            sum += np.std(rowVals)
            rowVals = []
        inputs.append(sum)   
         
        
def sum_col_stdev(set):
    #Calc sum of stdev from each col
    
    if SUM_COL_STDEVS:
        #print("Calc sum of stdev from each col")
        colVals = []
        sum = 0
        for col in range(WIDTH):
            for row in range(HEIGHT):
                if set < trainCount: #Compiling traindata
                    colVals.append(trainImages[set][row + HEIGHT*col])
                if not set < trainCount: #Compiling testdata
                    colVals.append(testImages[set-trainCount][row + HEIGHT*col])
            sum += np.std(colVals)
            colVals = []
        inputs.append(sum)   

def all_pixels(set):
    if ALL_PIXELS:
        if set < trainCount: #Compiling traindata
            inputs.extend(trainImages[set])
        if not set < trainCount: #Compiling testdata
            inputs.extend(testImages[set - trainCount])

#Open up traindata and testData
trainImages, trainLabels = loadlocal_mnist(trainIMGsFILE, trainLABsFILE)
testImages, testLabels = loadlocal_mnist(testIMGsFILE, testLABsFILE)


trainCount = trainLabels.shape[0]
testCount = testLabels.shape[0]
totalCount = trainCount + testCount


trainOutFile = open(outputTrain, "w")
testOutFile = open(outputTest, "w")

for set in range(totalCount): #EACH IMAGE
    print(str(set))
    if (set < trainCount and trainLabels[set] in labelsWant) or (not set < trainCount and testLabels[set- trainCount] in labelsWant):
        if set > MAX_TRAIN and set < trainCount:

            continue
        if set > trainCount + MAX_TEST:
            print("DONE WITH TEST")
            break    
        
        #THESE WILL ONLY RUN IF SET UP TOP
        indiv_row_pix_count(set)
        indiv_col_pix_count(set)
        indiv_row_stdev(set)
        indiv_col_stdev(set)
        total_bright_pix_count(set)
        sum_row_stdev(set)
        sum_col_stdev(set)
        all_pixels(set)
    
        inputString = ""
        for input in inputs:
            inputString += str(input) + " "
        inputs = []    

        if set < trainCount:
            output = str(trainLabels[set])
            trainOutFile.write(inputString + output + "\n")
        else:
            output = str(testLabels[set-trainCount]) 
            testOutFile.write(inputString + output + "\n")
trainOutFile.close
testOutFile.close

print(np.std([8,2,9,7,4,6,4]))