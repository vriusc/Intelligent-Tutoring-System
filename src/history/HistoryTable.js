import './History.css'
import { useEffect, useState } from 'react'
import { getRecordList } from '../lib/tutoring-client'
import { Table } from 'reactstrap'
import { BsChevronCompactLeft, BsChevronCompactRight } from 'react-icons/bs'
import { useTranslation } from 'react-i18next'

const HistoryTable = (args) => {
  const { studentId, questionId } = args
  const { t } = useTranslation()
  const [records, setRecords] = useState([])
  const [currentPage, setCurrentPage] = useState(0)
  const [totalPages, setTotalPages] = useState(1)

  useEffect(() => {
    getRecordList({ studentId, questionId, size: 5, page: currentPage }).then((response) => {
      const { content, totalPages } = response.data
      setRecords(content)
      setTotalPages(totalPages)
    })
  }, [currentPage])

  const isItCorrect = (options) => {
    return options.isCorrect === 1 ? t('correct_answer_upper') : t('incorrect_answer_upper')
  }

  const displayExplanation = (options, questions) => {
    const { isCorrect } = options
    const answer = questions.explanation || t('incorrect_answer')
    return isCorrect === 1 ? t('all_good') : answer
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

  const updatePagination = (newPage, disabled) => {
    if (!disabled) {
      setCurrentPage(newPage)
    }
  }

  return (
    <>
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
      {totalPages > 1 && (
        <div className="Pagination-container">
          <h6
            className={`Pagination-btn ${currentPage === 0 ? 'disabled' : ''}`}
            onClick={() => updatePagination(currentPage - 1, currentPage === 0)}
          >
            <BsChevronCompactLeft />
            Previous
          </h6>
          <h6
            className={`Pagination-btn ${currentPage + 1 === totalPages ? 'disabled' : ''}`}
            onClick={() => updatePagination(currentPage + 1, currentPage + 1 === totalPages)}
            color="danger"
          >
            Next
            <BsChevronCompactRight />
          </h6>
        </div>
      )}
    </>
  )
}

export default HistoryTable
