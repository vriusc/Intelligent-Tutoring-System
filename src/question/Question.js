import { Badge } from 'reactstrap'
import './Question.css'
import { useEffect, useState } from 'react'
import QuestionTextText from './QuestTextText'

const Question = (args) => {
  const { question, options, number, review, answersList, setAnswersList } = args
  const { questions: quest } = question
  const [optSelected, setOptSelected] = useState(null)
  const [isCorrect, setIsCorrect] = useState(2)

  const handleRadioBtn = (event, currentOption) => {
    setOptSelected(parseInt(event.target.value))
    if (currentOption.isCorrect === 1) {
      setAnswersList([...answersList, currentOption.questionId])
    }
  }

  useEffect(() => {
    if (review === true) {
      const currentOption = options.find((opt) => opt.optionId === optSelected)
      setIsCorrect(currentOption.isCorrect)
    } else {
      setIsCorrect(2)
    }
  }, [review])

  return (
    <div className="Question-container">
      {quest.questionId === 1 && (
        <QuestionTextText
          title={`${number}. ${quest.question}`}
          options={options}
          optSelected={optSelected}
          handleRadioBtn={handleRadioBtn}
          isCorrect={isCorrect}
        />
      )}
      {quest.questionId > 1 && (
        <h3>
          <Badge color="info">The question is not ready</Badge>
        </h3>
      )}
    </div>
  )
  // return (
  //   <div className="Question-container">
  //     <h5>{`${number}. ${quest.question}`}</h5>
  //     {review && isCorrect == 0 && <Alert color="danger">{quest.explanation}</Alert>}
  //     {review && isCorrect == 1 && <Alert>Correct Answer!</Alert>}
  //     {quest.questionTypeId === 1 && <img src={laptopImage} className="Quest-image" />}
  //     {quest.questionTypeId === 2 && (
  //       <audio controls className="Quest-audio">
  //         <source src={phoneAudio} type="audio/mpeg" />
  //       </audio>
  //     )}
  //     <div className="options-list">
  //       {options.map((currentOptions) => (
  //         <div key={currentOptions.optionId}>
  //           <Input
  //             type="radio"
  //             id={currentOptions.optionId}
  //             name={`${currentOptions.optionId}-${currentOptions.option}`}
  //             value={currentOptions.optionId}
  //             checked={currentOptions.optionId === optSelected}
  //             disabled={review}
  //             onChange={(event) => handleRadioBtn(event, currentOptions)}
  //           />
  //           <Label style={{ marginLeft: '0.5em' }}>{` ${currentOptions.option}`}</Label>
  //         </div>
  //       ))}
  //     </div>
  //   </div>
  // )
}

export default Question
