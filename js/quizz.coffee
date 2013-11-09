class Quizz
  @DefaultTimer: 10000
  @ResultSuccess: 'Right answer!'
  @ResultFailure: 'Wrong answer! :('

  constructor:()->
    console.log("Quizz object created")

    @list = [
      question: "What is the capital of Peru?"
      responses: [
        display: "Paris"
        valid: false
      ,
        display: "Lima"
        valid: true
      ,
        display: "Brussels"
        valid: false
      ]
    , 
      question: "Who named his company <em>Ta Mère</em>?"
      responses: [
        display: "Michaël Hoste"
        valid: false
      ,
        display: "Aurélien Malisart"
        valid: false
      ,
        display: "François Stephany"
        valid: true
      ]
    ,
      question: "What birthday are we celebrating today?"
      responses: [
        display: "Firefox's birthday"
        valid: true
      ,
        display: "Mozilla's birthday"
        valid: false
      ,
        display: "Firefox OS's birthday"
        valid: false
      ]
    ,
      question: "When is the next PechaKucha Mons organised?"
      responses: [
        display: "November 20, 2013"
        valid: true
      ,
        display: "November 21, 2013"
        valid: false
      , {
        display: "November 22, 2013"
        valid: false
      ]
    ,
      question: "What is the average lifespan of a red panda (firefox)?"
      responses: [
        display: "Between 1 and 3 years"
        valid: false
      ,
        display: "Between 8 and 10 years"
        valid: true
      ,
        display: "Between 15 and 20 years"
        valid: false
      ]
    ,
      question: "What does the fox say? (according to Yilvis)"
      responses: [
        display: "Ring-ding-ding-ding-dingeringeding!"
        valid: false
      ,
        display: "Wa-pa-pa-pa-pa-pa-pow!"
        valid: false
      ,
        display: "No one knows"
        valid: true
      ]
    ,
      question: "What does Dark Vader say to Luke?"
      responses: [
        display: "Luke, I am your father"
        valid: false
      ,
        display: "No. I am your father."
        valid: true
      ,
        display: "Yo, wassup my man?"
        valid: false
      ]
    ,
      question: "When is the next Friday 13?"
      responses: [
        display: "December 2013"
        valid: true
      ,
        display: "June 2014"
        valid: false
      ,
        display: "July 2014"
        valid: false
      ]
    ]
    
    @current = -1
    @score = 0
    @timer = Quizz.DefaultTimer

  answer:(answerID)->
    if @isValidAnswer(answerID)
      @score++

  getScore:()->
    return @score

  resetQuizz:()->
    @score=0
    @current=0
    @timer = Quizz.DefaultTimer
    return @

  getCurrentQuestionNumber:()->
    return @current+1

  getNumberOfQuestions:()->
    return @list.length

  getTimer:()->
    return @timer

  getNext:()->
    if @list[@current+1]
      @current++
      @timer = Quizz.DefaultTimer
      return @getCurrent()

  getCurrent:()->
    if @list[@current]?
       return @list[@current]

  isValidAnswer:(answerId)->
    console.log("answerId:#{answerId}")
    if @list[@current].responses[answerId]
      if @list[@current].responses[answerId].valid
        return true
    return false

  renderQuestionTemplate:(questionTemplate,question)->
    template = Handlebars.compile(questionTemplate)
    context = 
      timer: @timer
      current: @getCurrentQuestionNumber()
      number: @getNumberOfQuestions()
      question: question.question
      answer1: question.responses[0].display
      answer2: question.responses[1].display
      answer3: question.responses[2].display
    html = template(context)

  renderAnswerTemplate:(answerTemplate, question, answerId)->
    if @isValidAnswer(answerId)
      resultStatus = 'right'
      result = Quizz.ResultSuccess
    else
      resultStatus = 'wrong'
      result = Quizz.ResultFailure

    for response,id in question.responses
      if response.valid
        validId = id

    if @current+1 < @getNumberOfQuestions()
      nextQuestion = true
    else
      nextQuestion = false

    console.log("Next Question : #{nextQuestion}")

    template = Handlebars.compile(answerTemplate)
    context =
      resultStatus: resultStatus
      result: result
      answer: question.responses[validId].display
      score: @score
      nextQuestion: nextQuestion
      current: @getCurrentQuestionNumber()
    html = template(context)

window.Quizz = Quizz
