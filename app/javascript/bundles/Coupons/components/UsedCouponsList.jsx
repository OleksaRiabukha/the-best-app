import React from 'react';
import { Table } from 'react-bootstrap';
import NumberFormat from 'react-number-format';
import Moment from 'react-moment';


const UsedCouponsList = (props) => {
  const {coupons} = props;

  return (
    <Table striped bordered hover>
      <thead>
        <tr>
          <th>Coupon Number</th>
          <th>Used Amount</th>
          <th>Expired at</th>
        </tr>
      </thead>
      <tbody>
        {coupons.map((coupon) => (
          <tr key={coupon.id}>
            <td>{coupon.coupon_number}</td>
            <td>
              <NumberFormat
                value={coupon.initial_amount}
                displayType={'text'}
                thousandSeparator={true}
                prefix={'$'}
                decimalScale={2}
              />
            </td>
            <td>
              <Moment format='DD/MM/YYYY'>
                {coupon.updated_at}
              </Moment>
            </td>
          </tr>
        ))}
      </tbody>
    </Table>
  );
};

export default UsedCouponsList;
