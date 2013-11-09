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
      question: "test"
      responses: [
        display: "r1"
        valid: true
      ,
        display: "r1"
        valid: false
      ,
        display: "r1"
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
    template = Handlebars.compile(answerTemplate)
    context =
      resultStatus: resultStatus
      result: result
      answer: question.responses[validId].display
      score: @score
      current: @getCurrentQuestionNumber()
    html = template(context)

window.Quizz = Quizz
