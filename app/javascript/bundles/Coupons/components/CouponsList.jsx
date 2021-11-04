import React from 'react';

const CouponsList = (props) => {
  const {coupons} = props;

  if (coupons !== undefined ) {
    return (
      <div>
        <ul>
          {coupons.map((coupon) => (
            <li key={coupon.id}>
              {coupon.coupon_number}
            </li>
          ))}
        </ul>
      </div>
    );
  }
};
export default CouponsList;
