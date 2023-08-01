import './Question.css'
import { Input } from 'reactstrap'
import audiExample from '../assets/question2_audio.mp3'

const QuestionAudioPicture = (args) => {
  const { audio, options, handleRadioBtn, optSelected, disabled } = args
  const isYouTube = audio.search('youtube')

  const getName = (name) => {
    const splitName = name.split('/')
    return `${splitName[splitName.lenght - 2]}_${splitName[splitName.lenght - 1]}`
  }

  return (
    <>
      {audio && isYouTube && (
        <iframe className="Quest-video" width="420" height="315" src={audio} />
      )}
      {audio && !isYouTube && (
        <audio controls className="Quest-audio">
          <source src={audio} type="audio/mpeg" />
        </audio>
      )}
      {!audio && (
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
              disabled={disabled}
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
