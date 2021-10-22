import React from 'react';
import {Button, Modal} from 'react-bootstrap';

const ErrorModal = (props) => {
  const {show, closeErrorModal, showErrorModal} = props;

  return (
    <>
      <Modal
        show={show}
        onHide={closeErrorModal}
        centered
      >
        <Modal.Body>
          <span className="text-danger fs-5 fw-bold">
            Something went wrong. Please, try again or contact administrator.
          </span>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="warning" onClick={closeErrorModal}>
            Close
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
};

export default ErrorModal;
