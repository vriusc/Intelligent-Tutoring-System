import { Alert, Input, Label } from 'reactstrap'
import './Unit.css'
import { useEffect, useState } from 'react'
import laptopImage from '../assets/question1_image.jpeg'
import phoneAudio from '../assets/question2_audio.mp3'

const Question = (args) => {
  const { question, options, number, review } = args
  const { questions: quest } = question
  const [optSelected, setOptSelected] = useState(null)
  const [isCorrect, setIsCorrect] = useState(2)
  console.log(question, options)

  const handleRadioBtn = (event) => {
    setOptSelected(parseInt(event.target.value))
  }

  useEffect(() => {
    console.log('review', review)
    if (review === true) {
      // console.log('q', optSelected, options)
      const currentOption = options.find((opt) => opt.optionId === optSelected)
      setIsCorrect(currentOption.isCorrect)
      // console.log(currentOption, isCorrect, currentOption.isCorrect)
    } else {
      setIsCorrect(2)
    }
  }, [review])

  return (
    <div className="Question-container">
      <h5>{`${number}. ${quest.question}`}</h5>
      {review && isCorrect == 0 && <Alert color="danger">{quest.explanation}</Alert>}
      {review && isCorrect == 1 && <Alert>Correct Answer!</Alert>}
      {quest.questionTypeId === 1 && <img src={laptopImage} className="Quest-image" />}
      {quest.questionTypeId === 2 && (
        <audio controls className="Quest-audio">
          <source src={phoneAudio} type="audio/mpeg" />
        </audio>
      )}
      <div className="options-list">
        {options.map((currentOptions) => (
          <div key={currentOptions.optionId}>
            <Input
              type="radio"
              id={currentOptions.optionId}
              name={`${currentOptions.optionId}-${currentOptions.option}`}
              value={currentOptions.optionId}
              checked={currentOptions.optionId === optSelected}
              disabled={review}
              onChange={handleRadioBtn}
            />
            <Label style={{ marginLeft: '0.5em' }}>{` ${currentOptions.option}`}</Label>
          </div>
        ))}
      </div>
    </div>
  )
}

export default Question
