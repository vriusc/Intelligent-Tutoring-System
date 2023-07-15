import { Input } from 'reactstrap'
import './Question.css'

const QuestionTextPicture = (args) => {
  const { title, options, handleRadioBtn, optSelected } = args
  // const { title, options } = args
  console.log('options', options)

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
              type="radio"
              style={{ alignSelf: 'center' }}
              id={currentOptions.optionId}
              name={`${currentOptions.optionId}-${getName(currentOptions.option)}`}
              value={currentOptions.optionId}
              checked={currentOptions.optionId === optSelected}
              onChange={(event) => handleRadioBtn(event, currentOptions)}
            />
            <img src={currentOptions.option} className="Quest-image" />
          </div>
        ))}
      </div>
    </>
  )
}

export default QuestionTextPicture
