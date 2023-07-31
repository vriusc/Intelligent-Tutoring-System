import { Input, Label } from 'reactstrap'
import imageExample from '../assets/question1_image.jpeg'
import './Question.css'

const MultiQuestPictureText = (args) => {
  const { title, picture, options, handleCheckBoxBtn, optSelected, disabled } = args

  return (
    <>
      <h5>{title}</h5>
      {picture ? (
        <img src={picture} className="Quest-image" />
      ) : (
        <img src={imageExample} className="Quest-image" />
      )}
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

export default MultiQuestPictureText
