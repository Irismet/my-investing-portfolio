"""Add amount field to deals table

Revision ID: 04303e3f4e2e
Revises: ed1994b4b4c0
Create Date: 2024-11-24 00:17:40.221070

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '04303e3f4e2e'
down_revision = 'ed1994b4b4c0'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('deals', schema=None) as batch_op:
        batch_op.add_column(sa.Column('amount', sa.Numeric(precision=12, scale=2), nullable=False))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('deals', schema=None) as batch_op:
        batch_op.drop_column('amount')

    # ### end Alembic commands ###
