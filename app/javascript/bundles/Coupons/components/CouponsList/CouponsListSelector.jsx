import React, { useEffect, useState } from 'react';
import { Table } from 'react-bootstrap';

import UsedCouponsList from './UsedCouponsList.jsx';
import ActiveCouponsList from './ActiveCouponsList.jsx';

const CouponsListSelector = (props) => {
  const {coupons, availability} = props;
  return (
    <div>
      {availability ? <ActiveCouponsList coupons={coupons} /> : <UsedCouponsList coupons={coupons} />}
    </div>
  );
};

export default CouponsListSelector;
