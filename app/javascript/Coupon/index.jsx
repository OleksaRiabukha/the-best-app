import React from 'react';
import { Button, Form } from 'react-bootstrap';

function Coupon () {
  return(
    <Form>
      <Form.Group className="mb-3" controlId="couponFormAmount">
        <Form.Control type="amount" placeholder="Enter amount" />
      </Form.Group>
      <Form.Group className="mb-3" controlId="couponFormForPresent">
        <Form.Check type="checkbox" label="Do you buy it as a gift for someone?" />
      </Form.Group>
      <Button variant="primary" type="submit" className="btn-warning">
        Buy!
      </Button>
    </Form>
  ) 
}

export default Coupon;
