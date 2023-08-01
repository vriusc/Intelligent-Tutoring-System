import './Question.css'
import audiExample from '../assets/question2_audio.mp3'
import { Input, Label } from 'reactstrap'

const QuestionAudioText = (args) => {
  const { audio, options, handleRadioBtn, optSelected, disabled } = args
  const isYouTube = audio.search('youtube') >= 0

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
    </>
  )
}

export default QuestionAudioText
