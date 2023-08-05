import { Input } from 'reactstrap'
import './Question.css'
import { useEffect, useState } from 'react'

const QuestionTextPicture = (args) => {
  const { options, handleRadioBtn, optSelected, disabled } = args
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

  const getName = (name) => {
    const splitName = name.split('/')
    return `${splitName[splitName.lenght - 2]}_${splitName[splitName.lenght - 1]}`
  }

  return (
    <div className="Options-list">
      {newOptions.map((currentOptions) => (
        <div key={currentOptions.optionId} className="Quest-opt-image">
          <Input
            type="radio"
            style={{ alignSelf: 'center' }}
            id={currentOptions.optionId}
            name={`${currentOptions.optionId}-${getName(currentOptions.option)}`}
            disabled={disabled}
            value={currentOptions.optionId}
            checked={currentOptions.optionId === optSelected}
            onChange={(event) => handleRadioBtn(event, currentOptions)}
          />
          <img src={currentOptions.option} className="Option-image" />
        </div>
      ))}
    </div>
  )
}

export default QuestionTextPicture
