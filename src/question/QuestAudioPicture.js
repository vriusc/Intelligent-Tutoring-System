import './Question.css'
import { Input } from 'reactstrap'
import audiExample from '../assets/question2_audio.mp3'

const QuestionAudioPicture = (args) => {
  const { title, audio, options, handleRadioBtn, optSelected } = args
  // TODO: this is a continue work because it may be videos with audio
  // TODO: this type of question has not been created a data yet so it's not tested

  const getName = (name) => {
    const splitName = name.split('/')
    return `${splitName[splitName.lenght - 2]}_${splitName[splitName.lenght - 1]}`
  }

  return (
    <>
      <h5>{title}</h5>
      {audio ? (
        <audio controls className="Quest-audio">
          <source src={audio} type="audio/mpeg" />
        </audio>
      ) : (
        <audio controls className="Quest-audio">
          <source src={audiExample} type="audio/mpeg" />
        </audio>
      )}
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
            <img src={currentOptions.option} className="Option-image" />
          </div>
        ))}
      </div>
    </>
  )
}

export default QuestionAudioPicture
