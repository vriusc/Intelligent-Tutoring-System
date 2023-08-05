import './Question.css'
import { Input } from 'reactstrap'
import audiExample from '../assets/question2_audio.mp3'
import { useEffect, useState } from 'react'

const QuestionAudioPicture = (args) => {
  const { audio, options, handleRadioBtn, optSelected, disabled } = args
  const isYouTube = audio.search('youtube') >= 0
  const [newOptions, setNewOptions] = useState([])

  useEffect(() => {
    setNewOptions(shuffleOptions(options))
  }, [])

  const shuffleOptions = (list) => {
    let newList = []
    list.forEach((item) => {
      const flag = Math.floor(Math.random() * 10) + 1
      if (flag % 2 === 0) {
        newList = [...newList, item]
      } else {
        newList = [item, ...newList]
      }
    })
    return newList
  }

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
        {newOptions.map((currentOptions) => (
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
