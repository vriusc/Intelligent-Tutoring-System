import { Input } from 'reactstrap'
import './Question.css'

const MultiQuestTextPicture = (args) => {
  const { title, options, handleCheckBoxBtn, optSelected, disabled } = args

  const getName = (name) => {
    const splitName = name.split('/')
    return `${splitName[splitName.lenght - 2]}_${splitName[splitName.lenght - 1]}`
  }

  return (
    <>
      <h5>{title}</h5>
      <div className="Options-list">
        {options.map((currentOptions) => (
          <div key={currentOptions.optionId} className="Quest-opt-image">
            <Input
              type="checkbox"
              style={{ alignSelf: 'center' }}
              id={currentOptions.optionId}
              name={`${currentOptions.optionId}-${getName(currentOptions.option)}`}
              disabled={disabled}
              value={currentOptions.optionId}
              checked={optSelected && optSelected.some((opt) => opt === currentOptions.optionId)}
              onChange={(event) => handleCheckBoxBtn(event)}
            />
            <img src={currentOptions.option} className="Option-image" />
          </div>
        ))}
      </div>
    </>
  )
}

export default MultiQuestTextPicture
