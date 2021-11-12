import React from 'react';

import CouponsListSelector from './CouponsListSelector';

const CouponsList = (props) => {
  const {coupons, availability, setAvailability} = props;

  return (
    <div>
      <div>
        <button
          type="button"
          className="btn btn-warning me-1"
          onClick={() => setAvailability(true)}
        >
          Show Available
        </button>
        <button
          type="button"
          className="btn btn-warning"
          onClick={() => setAvailability(false)}
        >
          Show Used
        </button>
      </div>
      <div className="row mt-2">
        <CouponsListSelector coupons={coupons} availability={availability} />
      </div>
    </div>
  );
};

export default CouponsList;
