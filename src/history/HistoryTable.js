import './History.css'
import { useEffect, useState } from 'react'
import { getRecordList } from '../lib/tutoring-client'
import { Table } from 'reactstrap'

const HistoryTable = (args) => {
  const { studentId, questionId } = args
  const [records, setRecords] = useState([])

  useEffect(() => {
    getRecordList({ studentId, questionId, size: 30 }).then((response) => {
      const { content } = response.data
      setRecords(content)
    })
  }, [])

  const isItCorrect = (options) => {
    return options.isCorrect === 1 ? 'CORRECT ANSWER' : 'WRONG ANSWER'
  }

  const displayExplanation = (options, questions) => {
    const { isCorrect } = options
    const answer = questions.explanation || 'Wrong option'
    return isCorrect === 1 ? 'All good' : answer
  }

  const OptionsDisplay = (args) => {
    const { option, typeId } = args
    const pictureTypes = [2, 5, 7, 10]
    if (pictureTypes.some((id) => id === typeId)) {
      return (
        <td>
          <img src={option} className="History-image" />
        </td>
      )
    } else {
      return (
        <td>
          <p>{option}</p>
        </td>
      )
    }
  }

  return (
    <Table dark>
      <thead>
        <tr>
          <th>Result</th>
          <th>Option</th>
          <th>Explanation</th>
          {/* <th></th> */}
        </tr>
      </thead>
      <tbody>
        {records.map(({ options, questions }, index) => (
          <tr key={index} className={options.isCorrect === 1 ? '' : 'table-danger'}>
            <td>{isItCorrect(options)}</td>
            <OptionsDisplay option={options.option} typeId={questions.questionTypeId} />
            <td>{displayExplanation(options, questions)}</td>
            {/* <td>
              <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
                <Button color="info">Check</Button>
              </div>
            </td> */}
          </tr>
        ))}
      </tbody>
    </Table>
  )
}

export default HistoryTable
