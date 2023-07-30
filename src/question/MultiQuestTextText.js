import { Input, Label } from 'reactstrap'
import './Question.css'

const MultiQuestTextText = (args) => {
  const { title, options, handleCheckBoxBtn, optSelected, disabled } = args

  return (
    <>
      <h5>{title}</h5>
      <div className="Options-list">
        {options.map((currentOptions) => (
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

export default MultiQuestTextText
