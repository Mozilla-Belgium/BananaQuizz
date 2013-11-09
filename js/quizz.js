// Generated by CoffeeScript 1.6.3
var Quizz;

Quizz = (function() {
  Quizz.DefaultTimer = 3000;

  Quizz.ResultSuccess = 'Right answer!';

  Quizz.ResultFailure = 'Wrong answer!';

  function Quizz() {
    console.log("Quizz object created");
    this.list = [
      {
        question: "What is the capital of Peru?",
        responses: [
          {
            display: "Paris",
            valid: false
          }, {
            display: "Lima",
            valid: true
          }, {
            display: "Brussels",
            valid: false
          }
        ]
      }, {
        question: "test",
        responses: [
          {
            display: "r1",
            valid: true
          }, {
            display: "r1",
            valid: false
          }, {
            display: "r1",
            valid: false
          }
        ]
      }
    ];
    this.current = -1;
    this.score = 0;
    this.timer = Quizz.DefaultTimer;
  }

  Quizz.prototype.answer = function(answerID) {
    if (this.isValidAnswer(answerID)) {
      return this.score++;
    }
  };

  Quizz.prototype.getScore = function() {
    return this.score;
  };

  Quizz.prototype.resetQuizz = function() {
    this.score = 0;
    this.current = 0;
    this.timer = Quizz.DefaultTimer;
    return this;
  };

  Quizz.prototype.getCurrentQuestionNumber = function() {
    return this.current + 1;
  };

  Quizz.prototype.getNumberOfQuestions = function() {
    return this.list.length;
  };

  Quizz.prototype.getTimer = function() {
    return this.timer;
  };

  Quizz.prototype.getNext = function() {
    if (this.list[this.current + 1]) {
      this.current++;
      this.timer = Quizz.DefaultTimer;
      return this.getCurrent();
    }
  };

  Quizz.prototype.getCurrent = function() {
    if (this.list[this.current] != null) {
      return this.list[this.current];
    }
  };

  Quizz.prototype.isValidAnswer = function(answerId) {
    console.log("answerId:" + answerId);
    if (this.list[this.current].responses[answerId]) {
      if (this.list[this.current].responses[answerId].valid) {
        return true;
      }
    }
    return false;
  };

  Quizz.prototype.renderQuestionTemplate = function(questionTemplate, question) {
    var context, html, template;
    template = Handlebars.compile(questionTemplate);
    context = {
      timer: this.timer / 1000,
      current: this.getCurrentQuestionNumber(),
      number: this.getNumberOfQuestions(),
      question: question.question,
      answer1: question.responses[0].display,
      answer2: question.responses[1].display,
      answer3: question.responses[2].display
    };
    return html = template(context);
  };

  Quizz.prototype.renderAnswerTemplate = function(answerTemplate, question, answerId) {
    var context, html, id, nextQuestion, response, result, resultStatus, template, validId, _i, _len, _ref;
    if (this.isValidAnswer(answerId)) {
      resultStatus = 'right';
      result = Quizz.ResultSuccess;
    } else {
      resultStatus = 'wrong';
      result = Quizz.ResultFailure;
    }
    if (question != null) {
      _ref = question.responses;
      for (id = _i = 0, _len = _ref.length; _i < _len; id = ++_i) {
        response = _ref[id];
        if (response.valid) {
          validId = id;
        }
      }
    }
    if (this.current + 1 < this.getNumberOfQuestions()) {
      nextQuestion = true;
    } else {
      nextQuestion = false;
    }
    console.log("Next Question : " + nextQuestion);
    template = Handlebars.compile(answerTemplate);
    context = {
      resultStatus: resultStatus,
      result: result,
      answer: question.responses[validId].display,
      score: this.score,
      nextQuestion: nextQuestion,
      current: this.getCurrentQuestionNumber()
    };
    return html = template(context);
  };

  return Quizz;

})();

window.Quizz = Quizz;
