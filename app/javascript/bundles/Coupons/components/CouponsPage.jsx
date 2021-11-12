import React, { useState, useEffect } from 'react';
import axios from 'axios';

import CouponsList from './CouponsList/CouponsList';
import LoadingSpinner from './LoadingSpinner';
import EmptyList from './CouponsList/EmptyList';

const CouponsPage = (props) => {
  const [coupons, setCoupons] = useState([]);
  const [availability, setAvailability] = useState(true);
  const [loaded, setLoaded] = useState(false);

  useEffect(() => {
    getCouponsFromApi();
    setLoaded(false);
  }, [availability]);

  const getCouponsFromApi = async () => {
    const params = {scope: availability};
    await axios
        .get(props.path.concat('.json'), {params: params},
        )
        .then((response) => {
          setCoupons(response.data.coupons);
          setLoaded(true);
        })
        .catch((error) => {
          console.log(error);
        });
  };

  const renderList = () => {
    if (coupons.length === 0) {
      return <EmptyList />;
    } else {
      return <CouponsList
        coupons={coupons}
        availability={availability}
        setAvailability={setAvailability}
      />;
    }
  };

  return (
    <div className="container mt-4">
      {loaded ? renderList() : <LoadingSpinner />}
    </div>
  );
};

export default CouponsPage;
