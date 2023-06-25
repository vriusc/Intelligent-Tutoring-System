import { Input, Label } from 'reactstrap'
import './Unit.css'
import { useState } from 'react'
import laptopImage from '../assets/question1_image.jpeg'
import phoneAudio from '../assets/question2_audio.mp3'

const Question = (args) => {
  const { question, options, number } = args
  const { questions: quest } = question
  const [optSelected, setOptSelected] = useState(null)
  console.log(question, options)

  const handleRadioBtn = (event) => {
    console.log('select', event.target.value, optSelected)
    setOptSelected(event.target.value)
  }

  return (
    <div className="Question-container">
      <h5>{`${number}. ${quest.question}`}</h5>
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
              name={currentOptions.option}
              value={currentOptions.optionId}
              checked={currentOptions.optionId == optSelected}
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
