import { Input, Label } from 'reactstrap'
import imageExample from '../assets/question1_image.jpeg'
import './Question.css'

const QuestionPictureText = (args) => {
  const { title, picture, options, handleRadioBtn, optSelected } = args

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

export default QuestionPictureText
