import React from 'react';

const EmptyList = () => {
  const redirectToBuyCoupon = () => {
    window.location.href = '/coupons/new';
  };

  return (
    <div className="row">
      <p className="text-center font-monospace fw-bold fs-4 mt-5">
        You do not have coupons yet!
      </p>
      <p className="d-flex justify-content-center">
        <button
          className="btn btn-warning"
          type="button"
          onClick={() => {
            redirectToBuyCoupon();
          }}
        >
          Buy Coupons Here!
        </button>
      </p>
    </div>
  );
};

export default EmptyList;
