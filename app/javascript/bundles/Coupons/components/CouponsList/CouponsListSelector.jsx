import React, { useEffect, useState } from 'react';
import { Table } from 'react-bootstrap';

import UsedCouponsList from './UsedCouponsList.jsx';
import ActiveCouponsList from './ActiveCouponsList.jsx';

const CouponsListSelector = (props) => {
  const {coupons, availability} = props;
  const renderCouponsList = () => {
    switch (availability) {
      case true:
        return <ActiveCouponsList coupons={coupons} />;
      case false:
        return <UsedCouponsList coupons={coupons} />;
      default:
        return null;
    }
  };

  return (
    <div>
      {renderCouponsList()}
    </div>
  );
};

export default CouponsListSelector;
