import React, { useState } from 'react';
import ReactOnRails from 'react-on-rails';
import { useForm } from 'react-hook-form';
import { ErrorMessage } from '@hookform/error-message';
import _ from 'lodash/fp';
import axios from 'axios';

import ErrorModal from './ErrorModal';

require('dotenv').config();

const Coupons = (props) => {
  const [show, setShow] = useState(false);
  const closeErrorModal = () => setShow(false);
  const showErrorModal = () => setShow(true);

  const {
    register,
    handleSubmit,
    formState: {errors},
  } = useForm({
    mode: 'onBlur',
    criteriaMode: 'all',
    amount: 0,
  });

  const csfrHeader = {
    headers: {
      'X-CSRF-Token': ReactOnRails.authenticityToken(),
    },
  };

  const addCouponToUser = async (data) => {
    const requestBody = {
      coupon: {
        amount: data.amount,
        for_present: data.forPresent,
      },
    };

    await axios
        .post(props.path, requestBody, csfrHeader)
        .then(function(response) {
          if (response.status === 200) {
            window.location.href = response.data.session.url;
          }
        })
        .catch(function(error) {
          console.log(error);
          showErrorModal();
        });
  };

  return (
    <div className="form-group col-md-6 d-flex justify-content-center ">
      <form onSubmit={handleSubmit(addCouponToUser)}>
        <div className="mb-3">
          <input
            className="form-control"
            placeholder="Enter amount"
            {...register('amount', {
              required: 'Amount is required to buy coupon.',
              pattern: {
                value: /\d+/,
                message: 'Please, enter numbers only.',
              }})}
          />
          <ErrorMessage
            errors={errors}
            name="amount"
            render={({messages}) => {
              console.log('messages', messages);
              return messages ?
                _.entries(messages).map(([type, message]) => (
                  <div key={type} className="text-danger">{message}</div>
                )) :
                null;
            }}
          />
        </div>
        <div className="mb-3 form-check">
          <input
            className="form-check-input"
            id="coupon-check"
            name="forPresent"
            type="checkbox"
            value="true"
            {...register('forPresent')}
          />
          <label
            className="form-check-label"
            htmlFor="coupon-check"
          >
            Do you want to buy it as a gift to someone?
          </label>
        </div>
        <button type="submit" className="btn btn-warning">Buy</button>
      </form>
      <ErrorModal
        show={show}
        closeErrorModal={closeErrorModal}
        showErrorModal={showErrorModal}
      />
    </div>
  );
};

export default Coupons;
