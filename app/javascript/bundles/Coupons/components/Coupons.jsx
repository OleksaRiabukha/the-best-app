import React from 'react';
import {ErrorMessage} from '@hookform/error-message';
import _ from 'lodash/fp';
import {useForm} from 'react-hook-form';

const Coupons = () => {
  const {
    register,
    handleSubmit,
    formState: {errors},
  } = useForm({
    mode: 'onBlur',
    criteriaMode: 'all',
  });

  const onSubmit = (data) => console.log(data);

  return (
    <div className="form-group col-md-6 d-flex justify-content-center ">
      <form onSubmit={handleSubmit(onSubmit)}>
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
            name="for_present"
            type="checkbox"
            value="true"
            {...register('for_present')}
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
    </div>
  );
};

export default Coupons;
