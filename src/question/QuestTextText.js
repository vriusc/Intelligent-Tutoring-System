import { Input, Label } from 'reactstrap'
import './Question.css'
import { useEffect, useState } from 'react'

const QuestionTextText = (args) => {
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

  return (
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
  )
}

export default QuestionTextText
