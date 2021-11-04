import React, { useState, useEffect } from 'react';
import axios from 'axios';

import CouponsList from './CouponsList';

const CouponsIndexPage = (props) => {
  const [coupons, setCoupons] = useState([]);
  const [availability, setAvailability] = useState(true);

  useEffect(() => {
    getCouponsFromAPI();
  }, [availability]);


  const changeAvailability = (e) => {
    setAvailability(e.target.value);
  }

  const getCouponsFromAPI = async () => {
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

  return (
    <div>
      <div>
        <button type="button"
          onClick={(e) => changeAvailability(e)}
          value={true}
          className="btn btn-warning"
        >
          Active
        </button>
        <button
          type="button"
          onClick={(e) => changeAvailability(e)}
          value={false}
          className="btn btn-warning"
        >
          Used
        </button>
      </div>
      <div>
        <CouponsList coupons={coupons}/>
      </div>
    </div>
  );
};

export default CouponsIndexPage;
