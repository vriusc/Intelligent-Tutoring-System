import { Input, Label } from 'reactstrap'
import imageExample from '../assets/question1_image.jpeg'
import './Question.css'
import { useEffect, useState } from 'react'

const MultiQuestPictureText = (args) => {
  const { picture, options, handleCheckBoxBtn, optSelected, disabled } = args
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
              type="checkbox"
              id={currentOptions.optionId}
              name={`${currentOptions.optionId}-${currentOptions.option}`}
              disabled={disabled}
              value={currentOptions.optionId}
              checked={optSelected && optSelected.some((opt) => opt === currentOptions.optionId)}
              onChange={(event) => handleCheckBoxBtn(event)}
            />
            <Label style={{ marginLeft: '0.5em' }}>{` ${currentOptions.option}`}</Label>
          </div>
        ))}
      </div>
    </>
  )
}

export default MultiQuestPictureText
