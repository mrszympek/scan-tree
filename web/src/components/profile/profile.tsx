import { Typography } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import React from 'react';


export const Profile = () => {
  return (
    <div className="d-flex ai-center flex-column">
      <Avatar
        alt="Remy Sharp"
        className="avatar my-3"
        src="https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/8e/8e32b317249a5f410f1cfff1be8ad001f8b362e3_full.jpg"
      />
      <Typography variant={'h5'}>Batman</Typography>
      <Typography variant="subtitle2">Bruce Wayne</Typography>
    </div>
  );
};
