import { Input, Label } from 'reactstrap'
import './Question.css'

const QuestionTextText = (args) => {
  const { title, options, handleRadioBtn, optSelected } = args
  return (
    <>
      <h5>{title}</h5>
      <div className="Options-list">
        {options.map((currentOptions) => (
          <div key={currentOptions.optionId}>
            <Input
              type="radio"
              id={currentOptions.optionId}
              name={`${currentOptions.optionId}-${currentOptions.option}`}
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

export default QuestionTextText
