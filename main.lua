-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status ba 
display.setStatusBar(display.HiddenSatusBar)

--sets the background colour 
display.setDefault("background", 124/255, 249/255 , 199/255)
-----------------------------------------------------------------------------------------
--LOCAL VARIABLES 
-----------------------------------------------------------------------------------------

-- create local variables 
local questionObject 
local correctObject 
local numericField 
local randomNumber1
local randomNumber2
local userAnswer 
local correctAnswer 

-----------------------------------------------------------------------------------------
--LOCAL VARIABLES 
-----------------------------------------------------------------------------------------

local function AskQuestion ()
	--generate 2 random number between a max. and a min. number 
	randomNumber1 = math.random(0, 10)
	randomNumber2 = math.random(0, 10)

	correctAnswer = randomNumber1 + randomNumber2

	-- create question in text object 
	questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

end 

local function HideCorrect()
	correctObject.isVisible = false 
	AskQuestion()
end 	

local function NumericFieldListener(event)
	-- User begins edititing "numericField"
	if ( event.phase == "began" ) then 

		--clear text field 
	   	event.target.text = ""
	elseif event.phase == "submitted" then 

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
	    userAnswer = tonumber(event.target.text)

	    -- if the users answers and the correct answer are the same: 
	    if (userAnswer == correctAnswer) then 
	    	correctObject.isVisible = true 
	    	timer.performWithDelay(2000, HideCorrect)

	    else incorrectObject.isVisible = true
	    	timer.performWithDelay(3000 , HideIncorrect)
	    	event.target.text = ""
	    	secondsLeft = totalSeconds
	    	lives = lives -1 
	    	UpadateHeart()

	    end 
	end 
end 	

-----------------------------------------------------------------------------------------
--OBJECT CREATION
-----------------------------------------------------------------------------------------
 -- displays a question and sets the colour 
 questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50 )
 questionObject:setTextColor(155/255, 42/255, 198/255)

 --create the correct text object and make it invisble 
 correctObject = display.newText ("Correct!" , display.contentWidth/2 , display.contentHeight*2/3 , nil, 50)
correctObject:setTextColor(155/255, 42/255, 198/255)
 correctObject.isVisible = false 

 -- create the incorrect text object and make it invisible 
 

 -- Create numeric field 
 numericField = native.newTextField ( display.contentWidth*2/3, display.contentHeight/2, 150, 80 )
 numericField.inputType = "number"

 -- add the event listener for the numeric field 
 numericField:addEventListener("userInput", NumericFieldListener )

 -----------------------------------------------------------------------------------------
--FUNCTION CALLS
-----------------------------------------------------------------------------------------

-- call the function to ask the question 
AskQuestion()

--variables for the timer 
local totalSeconds = 5 
local secondsLeft = 5
local clockText 
local countDownTimer 

local lives = 3 
local heart1 
local heart2

--*** ADD LOCAL VARIABLE FOR : INCORRECT OBJECT, POINTS OBJECTS, POINTS 

----------------------------------------------------------------------------------------
--  LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function UpdateTimr()
	-- decrement the number of seconds 
	secondsLeft= secondsLeft - 1 
	--display the number of seconds left in the clock objects 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then 
		--reset the number of seconds left 
		secondsLeft = totalSeconds
		lives = lives - 1 

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A SOUND SHOW A YOU LOSE IMAGE 
		-- AND CANCEL THE TIMER REMORE THE THIRD HEART BY MAKING IT INVISIBLE 
		if (lives == 2) then 
			heart2.isVisible = false 
		elseif (lives == 1) then 
			heart1.isVisible = false 
		end 

		-- *** CALL THE FUNCTION TO ASK A NEW QUESTION 

	end 
end 

-- function thats calls the timer 
local function StartTime()
	-- create a countdown timer that loops infinitely 
	countdownTimer = time.performWithDelay( 1000, UpdateTime , 0)	
end 


----------------------------------------------------------------------------------------
--OBJECT CREATION
-----------------------------------------------------------------------------------------

-- create the lives to displa on the screen 
heart1 = display.newImageRect("Images/heart.png" , 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png" , 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png" , 100, 100)
heart3.x = display.contentWidth * 4.5/ 8
heart2.y = display.contentHeight * 1/ 7
