import React, { useState, useEffect } from 'react';
import axios from 'axios';

import CouponsList from './CouponsList';

const CouponsIndexPage = (props) => {
  const [coupons, setCoupons] = useState([]);
  const [availability, setAvailability] = useState(true);
  const available = () => setAvailability(true);
  const used = () => setAvailability(false);

  useEffect(() => {
    getCouponsFromApi();
  }, [availability]);

  const getCouponsFromApi = async () => {
    const params = {scope: availability};

    await axios
        .get(props.path.concat('.json'), {params: params},
        )
        .then(function(response) {
          if (response.status === 200) {
            setCoupons(response.data.coupons);
          }
        })
        .catch(function(error) {
          console.log(error);
        });
  };

  const redirectToBuyCoupon = (e) => {
    window.location.href = '/coupons/new';
  };

  const emptyList = () => {
    return (
      <div className="row">
        <p className="text-center font-monospace fw-bold fs-4 mt-5">
          You do not have coupons yet!
        </p>
        <p className="d-flex justify-content-center">
          <button
            className="btn btn-warning"
            type="button"
            onClick={(e) => {
              redirectToBuyCoupon(e);
            }}
          >
            Buy Coupons Here!
          </button>
        </p>
      </div>
    );
  };

  const couponsList = () => {
    return (
      <div>
        <div>
          <button
            type="button"
            className="btn btn-warning me-1"
            onClick={() => available()}
          >
            Show Available
          </button>
          <button
            type="button"
            className="btn btn-warning"
            onClick={() => used()}
          >
            Show Used
          </button>
        </div>
        <div className="row mt-2">
          <CouponsList coupons={coupons} availability={availability} />
        </div>
      </div>
    );
  };

  return (
    <div className="container mt-4">
      {coupons.length > 0 ? couponsList() : emptyList()}
    </div>
  );
};

export default CouponsIndexPage;
