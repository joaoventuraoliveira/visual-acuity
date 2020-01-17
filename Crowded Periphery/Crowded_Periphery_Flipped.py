#Crowded Periphery
#Created by Patrick Wilson on 11/29/2019 
#Github.com/patrickmwilson
#Created for the Elegant Mind Collaboration at UCLA under Professor Katsushi Arisaka
#Copyright © 2019 Elegant Mind Collaboration. All rights reserved.

from __future__ import absolute_import, division

import psychopy
psychopy.useVersion('latest')

from psychopy import locale_setup, prefs, sound, gui, visual, core, data, event, logging, clock, monitors
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)
from psychopy.hardware import keyboard

import numpy as np  
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle

import os, sys, time, random, math, csv

#CSVWRITER FUNCTION
def csvOutput(output):
    with open(filename,'a', newline ='') as csvFile:
        writer = csv.writer(csvFile)
        writer.writerow(output)
    csvFile.close()

#CLOSE WINDOW, FLUSH LOG, STOP SCRIPT EXECUTION
def endExp():
    win.flip()
    logging.flush()
    win.close()
    core.quit()

#Y/N INPUT DIALOGUE FOR DATA RECORDING
datadlg = gui.Dlg(title='Record Data?', pos=None, size=None, style=None, labelButtonOK=' Yes ', labelButtonCancel=' No ', screen=-1)
ok_data = datadlg.show()
recordData = datadlg.OK

#Y/N INPUT DIALOGUE FOR GLASSES
datadlg = gui.Dlg(title='Does the subject wear glasses?', pos=None, size=None, style=None, labelButtonOK=' Yes ', labelButtonCancel=' No ', screen=-1)
ok_data = datadlg.show()
glasses = datadlg.OK

#Y/N INPUT DIALOGUE FOR KEY REMAPPING
datadlg = gui.Dlg(title='Remap keys?', pos=None, size=None, style=None, labelButtonOK=' Yes ', labelButtonCancel=' No ', screen=-1)
ok_data = datadlg.show()
remap = datadlg.OK

if recordData:
    #OUTPUT FILE PATH
    PATH = 'C:\\Users\\chand\\OneDrive\\Documents\\GitHub\\Elegant-Mind-Collaboration\\Crowded Periphery'
    OUTPATH = '{0:s}\\Data\\'.format(PATH)
    
    #CD TO SCRIPT DIRECTORY
    _thisDir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(_thisDir)
    #STORE INFO ABOUT EXPERIMENT SESSION
    expName = 'Crowded Periphery Flipped'
    date = data.getDateStr(format='%m-%d') 
    expInfo = {'Participant': ''}
    
    #DIALOGUE WINDOW FOR PARTICIPANT NAME
    dlg = gui.DlgFromDict(dictionary=expInfo, sortKeys=False, title=expName)
    if dlg.OK == False:
        core.quit()
    
    #CREATE FILE NAME, PRINT HEADER IF FILE DOESN'T EXIST
    filename = OUTPATH + u'%s_%s_%s' % (expInfo['Participant'], date, expName) + '.csv'
    if not os.path.isfile(filename):
        csvOutput(["Direction","Letter Height (degrees)","Eccentricity (degrees)"]) 

#WINDOW CREATION
mon = monitors.Monitor('TV')
mon.setWidth(200)
win = visual.Window(
    size=(3840, 2160), fullscr=False, screen=-1, 
    winType='pyglet', allowGUI=True, allowStencil=False,
    monitor= mon, color='grey', colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='cm')

#CREATE DEFAULT KEYBOARD
defaultKeyboard = keyboard.Keyboard()
keyPress = keyboard.Keyboard()

#EXPERIMENTAL VARIABLES
letters = list("EPB")
anglesH = [0, 5, 10, 15, 20, 25, 30, 35, 40]
anglesV = [5, 10, 15, 20, 25, 30]
directionsG = [0, 2]
directionsNG = [0, 1, 2, 3]
distToScreen = 50 #cm

if glasses:
    directions = directionsG
else:
    directions = directionsNG

if remap:
    keys = ['z', 'x', 'n', 'm', 'escape', 'space']
else:
    keys = ['e', 'p', 'b', 'escape', 'space']

#SPACING ADJUSTMENTS FOR TEXT DISPLAY
dirXMult = [1.62, 0, -1.68, 0]
dirYMult = [0, -1.562, 0, 1.748]
yOffset = [0.2, 0, 0.2, 0]

#GENERATE TEXT STIM OBJECT
def genDisplay(text, xPos, yPos, height, colour):
    displayText = visual.TextStim(win=win,
    text= text,
    font='Arial',
    pos=(xPos, yPos), height=height, wrapWidth=500, ori=0, 
    color=colour, colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0)
    return displayText

#STAIRCASE ALGORITHM TO DETERMINE MINIMUM LEGIBLE SIZE
def stairCase(thisResponse, numReversals, totalReversals, size, stairCaseCompleted, lastResponse, responses):
    responses += 1
    #IF TWO SEQUENTIAL IN/CORRECT ANSWERS, RESET NUMREVERSALS
    if numReversals > 0 and lastResponse == thisResponse:
        totalReversals += numReversals
        numReversals = 0
    #IF CORRECT, MOVE CHARACTER OUTWARD
    if thisResponse:
        if numReversals == 0 and size > 1:
            size -= 0.5
        elif(size > 0.5):
            size -= 0.2
        else:
            size -= 0.1
    #IF INCORRECT, MOVE CHARACTER INWARD, INCREMENT NUMREVERSALS
    else:
        numReversals += 1
        if size > 0.5:
            size += 0.2
        else:
            size += 0.1
    #COMPLETE STAIRCASE IF THE MAX ANGLE IS REACHED, OR 3 REVERSALS OR 25 RESPONSES OCCUR
    if numReversals >= 3 or responses >= 25 or totalReversals > 15:
        stairCaseCompleted = True
        
    if size < 0.1:
        size = 0.1
        
    return stairCaseCompleted, size, numReversals, totalReversals, thisResponse, responses

#CONVERT DEGREE INPUT TO DISTANCE IN CENTIMETERS
def angleCalc(angle):
    radians = math.radians(angle)
    spacer = (math.tan(radians)*distToScreen)
    return spacer
    
#GENERATE A RANDOMIZED 3X3 ARRAY OF LETTERS, RETURN CENTER LETTER
def genArray():
    array = ''
    list = ['']*11
    for i in range(11):
        if i == 3 or i == 7:
            list[i] = '\n'
        else:
            list[i] = random.choice(letters)
    array = ''.join(list)
    return array, list[5]

#CALCULATE DISPLAY COORDINATES AND HEIGHT OF STIMULI
def displayVariables(angle, dir):
    #DISPLAY HEIGHT AND DISTANCE FROM CENTER IN CENTIMETERS
    heightCm = (angleCalc(size)*2.3378)
    angleCm = angleCalc(angle)
    #X AND Y DISPLAY COORDINATES
    xPos = (dirXMult[dir]*angleCm) 
    yPos = (dirYMult[dir]*angleCm) + yOffset[dir]
    #ADJUSTMENT TO CENTER CHARACTER
    if angle == 0 and dir%2 != 0:
        yPos += 0.2
    return heightCm, angleCm, xPos, yPos
    
def checkResponse(response, letter):
    key = '0'
    if(remap):
        if response[0] == 'z':
            key = 'b'
        elif response[0] == 'x':
            key = 'e'
        elif response[0] == 'n':
            key = 'p'
        elif response[0] == 'm':
            key = 'space'
    else:
        key = response[0]
    
    return (key == letter.lower())

#DISPLAY INSTRUCTIONS FOR CHINREST ALIGNMENT
instructions = genDisplay('  Align the edge of the headrest stand \nwith the edge of the tape marked 50cm \n\n       Press Spacebar to continue', 0, 5, 5, 'black')
instructions.draw()
win.flip()
theseKeys = event.waitKeys(keyList = ['space', 'escape'], clearEvents = False)
if theseKeys[0] == 'escape':
    endExp()

#GENERATE CENTER DOT
dot = genDisplay('.', 0, 1.1, 4, [.207,1,.259])

#RANDOMIZE SIZES, LOOP THROUGH 
#shuffle(sizes)
#for size in sizes:
shuffle(directions)
for dir in directions:
    
    #RANDOMIZE DIRECTIONS, LOOP THROUGH
    #shuffle(directions)
    #for dir in directions:
    if(dir == 0 or dir == 2):
        angles = list(anglesH)
    else:
        angles = list(anglesV)
    shuffle(angles)
    for angle in angles:

        #INITIALIZE TRIAL VARIABLES
        size = angle/10
        if(size == 0):
            size = 1
        numReversals = 0
        totalReversals = 0
        responses = 0
        stairCaseCompleted = False
        lastResponse = False
        
        while not stairCaseCompleted:
            
            #GENERATE NEW STIMULI
            array, letter = genArray()
            heightCm, angleCm, xPos, yPos = displayVariables(angle, dir)
            displayText = genDisplay(array, xPos, yPos, heightCm, 'white')
            
            if responses == 0:
                dot.draw()
                win.flip()
            
            time.sleep(0.5)
            
            flash = 0
            while 1:
                flash = (flash == 0)
                if flash:
                    dot.draw()
                displayText.draw()
                win.callOnFlip(keyPress.clearEvents, eventType='keyboard')
                win.flip()
                theseKeys = event.waitKeys(maxWait = 0.025, keyList = keys, clearEvents = False)
                if theseKeys:
                    break
            
            #STOP SCRIPT IF ESCAPE IS PRESSED
            if theseKeys[0] == 'escape':
                endExp()
            
            #CHECK KEYPRESS AGAINST TARGET LETTER
            thisResponse = checkResponse(theseKeys, letter)
            
            #CALL STAIRCASE ALGORITHM
            stairCaseCompleted, size, numReversals, totalReversals, lastResponse, responses = stairCase(thisResponse, numReversals, totalReversals, size, stairCaseCompleted, lastResponse, responses)
            
            if stairCaseCompleted:
                #INCREMENT DIR NUMBER FOR CSV OUTPUT TO FACILITATE ANALYSIS (1=R, 2=D...)
                direction = dir+1
                #CSV OUTPUT
                if recordData:
                    csvOutput([direction, size, angle])

endExp()