import React from 'react';
import { Table } from 'react-bootstrap';
import NumberFormat from 'react-number-format';

const ActiveCouponsList = (props) => {
  const {coupons} = props;

  return (
    <Table striped bordered hover>
      <thead>
        <tr>
          <th>Coupon Number</th>
          <th>Amount Left</th>
          <th>Initial Amount</th>
        </tr>
      </thead>
      <tbody>
        {coupons.map((coupon) => (
          <tr key={coupon.id}>
            <td>{coupon.coupon_number}</td>
            <td>
              <NumberFormat
                value={coupon.amount_left}
                displayType={'text'}
                thousandSeparator={true}
                prefix={'$'}
                decimalScale={2}
              />
            </td>
            <td>
              <NumberFormat
                value={coupon.initial_amount}
                displayType={'text'}
                thousandSeparator={true}
                prefix={'$'}
                decimalScale={2}
              />
            </td>
          </tr>
        ))}
      </tbody>
    </Table>
  );
};

export default ActiveCouponsList;
