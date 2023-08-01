import { Alert } from 'reactstrap'
import './Question.css'
import { useEffect, useState } from 'react'
import QuestionTextText from './QuestTextText'
import QuestionTextPicture from './QuestTextPicture'
import QuestionPictureText from './QuestPictureText'
import QuestionAudioText from './QuestAudioText'
import QuestionAudioPicture from './QuestAudioPicture'
import MultiQuestTextText from './MultiQuestTextText'
import MultiQuestTextPicture from './MultiQuestTextPicture'
import MultiQuestPictureText from './MultiQuestPictureText'
import MultiQuestAudioText from './MultiQuestAudioText'
import MultiQuestAudioPicture from './MultiQuestAudioPicture'

const Question = (args) => {
  const {
    question,
    options,
    number,
    review,
    answersList,
    setAnswersList,
    disabled,
    radioSelected,
    multiSelected
  } = args
  const { questions: quest } = question
  const [optSelected, setOptSelected] = useState(null)
  const [optMultple, setOptMultple] = useState([])
  const [isCorrect, setIsCorrect] = useState(2)
  const [errorText, setErrorText] = useState('')

  useEffect(() => {
    if (radioSelected) {
      setOptSelected(radioSelected)
    }
    if (multiSelected && multiSelected.length >= 1) {
      setOptMultple(multiSelected)
    }
  }, [radioSelected, multiSelected])

  const handleRadioBtn = (event, currentOption) => {
    const answerOptionID = parseInt(event.target.value)
    setOptSelected(answerOptionID)
    setIsCorrect(currentOption.isCorrect)

    const answerList = answersList.map((element) => {
      if (element.questionId === quest.questionId) {
        element.myOptions = [currentOption]
      }
      return element
    })
    setAnswersList(answerList)
  }

  const handleCheckBoxBtn = (event) => {
    const selected = parseInt(event.target.value)
    let multipleArray = []
    if (optMultple.some((opt) => opt === selected)) {
      multipleArray = [...optMultple.filter((opt) => opt !== selected)]
    } else {
      multipleArray = [...optMultple, selected]
    }
    setOptMultple(multipleArray)
    multipleErrorReview(multipleArray)

    const answerList = answersList.map((element) => {
      if (element.questionId === quest.questionId) {
        element.myOptions = [
          ...options.filter((opt) => multipleArray.some((multi) => multi === opt.optionId))
        ]
      }
      return element
    })
    setAnswersList(answerList)
  }

  const multipleErrorReview = (list) => {
    const totalCount = options.filter((opt) => opt.isCorrect === 1).length
    const correctCount = list.filter((id) => {
      const myOpt = options.find((opt) => opt.optionId === id)
      return myOpt && myOpt.isCorrect === 1
    }).length
    if (totalCount === correctCount && correctCount === list.length) {
      setIsCorrect(1)
    } else {
      setIsCorrect(0)
      if (correctCount === 0) {
        setErrorText('All the answers are wrong')
      } else if (totalCount > correctCount && correctCount > 0) {
        setErrorText('You have partially right')
      }
    }
  }

  return (
    <div className="Question-container">
      <h5>{`${number}. ${quest.question}`}</h5>
      {quest.questionTypeId === 1 && (
        <QuestionTextText
          options={options}
          optSelected={optSelected}
          handleRadioBtn={handleRadioBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 2 && (
        <QuestionTextPicture
          title={`${number}. ${quest.question}`}
          options={options}
          optSelected={optSelected}
          handleRadioBtn={handleRadioBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 3 && (
        <QuestionPictureText
          title={`${number}. ${quest.question}`}
          picture={quest.picturePath}
          options={options}
          optSelected={optSelected}
          handleRadioBtn={handleRadioBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 4 && (
        <QuestionAudioText
          title={`${number}. ${quest.question}`}
          audio={quest.audioPath}
          options={options}
          optSelected={optSelected}
          handleRadioBtn={handleRadioBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 5 && (
        <QuestionAudioPicture
          title={`${number}. ${quest.question}`}
          audio={quest.audioPath}
          options={options}
          optSelected={optSelected}
          handleRadioBtn={handleRadioBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 6 && (
        <MultiQuestTextText
          title={`${number}. ${quest.question}`}
          options={options}
          optSelected={optMultple}
          handleCheckBoxBtn={handleCheckBoxBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 7 && (
        <MultiQuestTextPicture
          title={`${number}. ${quest.question}`}
          options={options}
          optSelected={optMultple}
          handleCheckBoxBtn={handleCheckBoxBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 8 && (
        <MultiQuestPictureText
          title={`${number}. ${quest.question}`}
          picture={quest.picturePath}
          options={options}
          optSelected={optMultple}
          handleCheckBoxBtn={handleCheckBoxBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 9 && (
        <MultiQuestAudioText
          title={`${number}. ${quest.question}`}
          audio={quest.audioPath}
          options={options}
          optSelected={optMultple}
          handleCheckBoxBtn={handleCheckBoxBtn}
          disabled={disabled}
        />
      )}
      {quest.questionTypeId === 10 && (
        <MultiQuestAudioPicture
          title={`${number}. ${quest.question}`}
          audio={quest.audioPath}
          options={options}
          optSelected={optMultple}
          handleCheckBoxBtn={handleCheckBoxBtn}
          disabled={disabled}
        />
      )}
      {review && isCorrect == 0 && (
        <Alert color="danger">{quest.explanation || errorText || 'Your answer is incorrect'}</Alert>
      )}
      {review && isCorrect == 1 && <Alert>Correct Answer!</Alert>}
    </div>
  )
}

export default Question
