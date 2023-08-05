import './Question.css'
import audiExample from '../assets/question2_audio.mp3'
import { Input, Label } from 'reactstrap'
import { useEffect, useState } from 'react'

const MultiQuestAudioText = (args) => {
  const { audio, options, handleCheckBoxBtn, optSelected, disabled } = args
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

export default MultiQuestAudioText
