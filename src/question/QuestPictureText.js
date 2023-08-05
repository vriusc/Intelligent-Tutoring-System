import { Input, Label } from 'reactstrap'
import imageExample from '../assets/question1_image.jpeg'
import './Question.css'
import { useEffect, useState } from 'react'

const QuestionPictureText = (args) => {
  const { picture, options, handleRadioBtn, optSelected, disabled } = args
  const [newOptions, setNewOptions] = useState([])

  useEffect(() => {
    setNewOptions(shuffleOptions(options))
  }, [])

  const shuffleOptions = (list) => {
    let newList = []
    list.forEach((item) => {
      const flag = Math.floor(Math.random() * 10) + 1
      if (flag % 2 === 0) {
        newList = [...newList, item]
      } else {
        newList = [item, ...newList]
      }
    })
    return newList
  }

  return (
    <>
      {picture ? (
        <img src={picture} className="Quest-image" />
      ) : (
        <img src={imageExample} className="Quest-image" />
      )}
      <div className="Options-list">
        {newOptions.map((currentOptions) => (
          <div key={currentOptions.optionId}>
            <Input
              type="radio"
              id={currentOptions.optionId}
              name={`${currentOptions.optionId}-${currentOptions.option}`}
              disabled={disabled}
              value={currentOptions.optionId}
              checked={currentOptions.optionId === optSelected}
              onChange={(event) => handleRadioBtn(event, currentOptions)}
            />
            <Label style={{ marginLeft: '0.5em' }}>{` ${currentOptions.option}`}</Label>
          </div>
        ))}
      </div>
    </>
  )
}

export default QuestionPictureText
