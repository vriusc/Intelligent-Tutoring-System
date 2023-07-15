import './Question.css'
import audiExample from '../assets/question2_audio.mp3'
import { Input, Label } from 'reactstrap'

const QuestionAudioText = (args) => {
  const { title, audio, options, handleRadioBtn, optSelected } = args
  // const { title, audio, options } = args
  console.log('options', options, audio)
  // TODO: this is a continue work because it may be videos with audio

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

export default QuestionAudioText
