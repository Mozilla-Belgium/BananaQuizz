class Quizz
  DefaultTimer: 10000

  constructor:()->
    console.log("Quizz object created")
    @list = [
      question: "test"
      responses: [
        display: "r1"
        valid: false
      ,
        display: "r1"
        valid: true
      ,
        display: "r1"
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
    @current = 0
    @score = 0

  getScore:()->
    return @score

  resetQuizz:()->
    @score=0
    @current=0
    return @

  getNumberOfQuestions:()->
    return @list.length

  getTimer:()->
    return @timer

  getNext:()->
    if  @list[@current+1]
      @current++
      @timer = Quizz.DefaultTimer
      return @getCurrent()
      

  getCurrent:()->
    if @list[@current]?
       return @list[@current]

  isValidAnswer:(answerId)->
    if @list[@current].response[answerId]
      @list[@current].response[answerId].valid

window.Quizz = Quizz
